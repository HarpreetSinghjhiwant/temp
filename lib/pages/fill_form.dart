// Import Statements
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';
import 'package:temp/theme/custom_button_style.dart';
import 'package:temp/widgets/custom_icon_button.dart';
import 'package:temp/widgets/custom_outlined_button.dart';
import 'package:temp/widgets/custom_text_form_field.dart';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
// End of Import Statements

// Statefull Fill Form Widget
class FillForm extends StatefulWidget {
  FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  // Controllers to handle text input for bride and groom details
  final List<TextEditingController> brideControllers =
      List.generate(5, (index) => TextEditingController());
  final List<TextEditingController> groomControllers =
      List.generate(5, (index) => TextEditingController());

  TextEditingController weddingDateController = TextEditingController();

  // Keeps track of selected side (Bride or Groom)
  String side = 'Bride';

  Map<String,String> languageCode = {
    'English': 'en',
    'हिंदी': 'hi',
    'தமிழ்': 'ta',
    'मराठी': 'mr',
    'తెలుగు': 'te',
    'ગુજરાતી': 'gu',
  };

  String selectedLang = 'English';

  // Toggles the display of instruction modal
  bool isInst = true;

  // Stores event data as a list of maps
  List<Map<String, String>> eventList = [];

  // Manages expansion states for form sections
  List<bool> isExpandedList = [true, false, false];
  List<bool> isCompletedList = [false, false, false];

  int currentPage = 0; // Current form page being viewed
  int tempCurrentPage = 0; // Temporarily tracks current page

  final List<ExpansionTileController> expansionControllers =
      List.generate(3, (index) => ExpansionTileController());

  // Controllers for event form inputs
  final List<TextEditingController> eventControllers =
      List.generate(3, (index) => TextEditingController());

  // Tracks whether in edit mode for events
  bool isEdit = false;
  bool isSelect = false;

  FocusNode dateFocusNode = FocusNode(); // Focus node for date input field

  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Audio player instance for playing music

  bool isPlaying = false; // Track whether audio is currently playing

  int? currentlyPlayingIndex;

  bool isDropdownVisible =
      false; // Controls visibility of dropdown for music selection

  

  Map<String, dynamic> data = {};

  final _brideAndGroomKey =
      GlobalKey<FormState>(); // Key to validate bride and groom name form

  final _langAndDateKey =
      GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  bool caricature = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadData();
  }

//// Dispose Method
  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }
//// End of Dispose Method

//// Local storage function

// Save data to Hive
  Future<void> saveData(Map<String, dynamic> formData) async {
  try {
    final box = await Hive.openBox('formDataBox');
    String jsonString = jsonEncode(formData);
    await box.put('formData', jsonString);
    print('Data saved successfully: $jsonString'); // Add logging
  } catch (e) {
    print('Error saving data: $e');
  }
}

// Load data from Hive
  Future<void> loadData() async {
  try {
    final box = await Hive.openBox('formDataBox');
    String? jsonString = box.get('formData');
    print('Loaded data from Hive: $jsonString'); // Add logging

    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> dataFiles = jsonDecode(jsonString);
      
      // Add null checks and default values
      setState(() {
        selectedLang = dataFiles['language'] ?? 'English';
        side = dataFiles['side'] ?? 'Bride';
        weddingDateController.text = dataFiles['weddingDate'] ?? '';
        
        // Load groom details with null checks
        groomControllers[0].text = dataFiles['groomName'] ?? '';
        groomControllers[1].text = dataFiles['groomMother'] ?? '';
        groomControllers[2].text = dataFiles['groomFather'] ?? '';
        groomControllers[3].text = dataFiles['groomGrandmother'] ?? '';
        groomControllers[4].text = dataFiles['groomGrandfather'] ?? '';
        
        // Load bride details with null checks
        brideControllers[0].text = dataFiles['brideName'] ?? '';
        brideControllers[1].text = dataFiles['brideMother'] ?? '';
        brideControllers[2].text = dataFiles['brideFather'] ?? '';
        brideControllers[3].text = dataFiles['brideGrandmother'] ?? '';
        brideControllers[4].text = dataFiles['brideGrandfather'] ?? '';
        
        // Load events with proper type casting
        try {
          List<dynamic> decodedEvents = jsonDecode(dataFiles['events'] ?? '[]');
          eventList = decodedEvents
              .map((e) => Map<String, String>.from(e))
              .toList();
        } catch (e) {
          print('Error parsing events: $e');
          eventList = [];
        }
        
        // Update UI states
        isExpandedList[0] = false;
          expansionControllers[0].collapse();
          for (int i = 0; i < 4; i++) {
            isCompletedList[i] = true;
          }
      });
    }
  } catch (e) {
    print('Error loading data: $e');
  }
}
//// End of Load data function


//// Get Date With suffix function
  String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "${day}th";
    }
    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }
//// End of Get Date Function

  String truncateText(String text, int limit) {
    return text.length > limit ? '${text.substring(0, limit)}...' : text;
  }

//// Format Date Time Function
  String formatDateTime(DateTime date, {TimeOfDay? time}) {
    String dayWithSuffix = getDayWithSuffix(date.day);
    String month = DateFormat('MMMM').format(date); // Full month name
    String year = date.year.toString();

    if (time != null) {
      String formattedTime =
          time.format(context).toLowerCase(); // Time in am/pm
      return "$dayWithSuffix $month $year | $formattedTime Onwards";
    } else {
      return "$dayWithSuffix $month $year";
    }
  }
//// End of Format Date and Time function

//// Pick Date and Time Function
  void pickDateTime(BuildContext context) async {
    // Unfocus the date field to prevent keyboard appearance
    dateFocusNode.unfocus();

    // Pick the date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  Color(0xFF4E9459), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Pick the time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary:
                    Color(0xFF4E9459), // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedDateTime = formatDateTime(pickedDate, time: pickedTime);
        setState(() {
          eventControllers[1].text = formattedDateTime;
        });
      }
    }
  }
//// End of Date and Time picker function

//// Event Format function
  String eventFormat() {
    String a = '';
    for (int i = 0; i < eventList.length; i++) {
      a += eventList[i]['name']!;
      if (i != eventList.length - 1) {
        a += ' | ';
      }
    }
    return a;
  }
//// End of Format Function

  /// Build Widget
  @override
  Widget build(BuildContext context) {
    return Theme(
      data:theme,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Same as the AppBar background color
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Color of the border
                  width: 1.0, // Thickness of the border
                ),
              ),
            ),
            child: AppBar(
              backgroundColor:
                  Colors.transparent, // Make the AppBar background transparent
              elevation: 0,
              leading: Icon(Icons.arrow_back_ios_new,
                  color: Colors.black), // Remove default AppBar shadow
              title: Center(
                child: Image.asset(
                  ImageConstant.celebrareImage,
                  width: 144,
                  height: 39,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Need Help ?',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(153, 153, 153, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: !isExpandedList[index]
                    ? const EdgeInsets.only(top: 24)
                    : EdgeInsets.zero,
                child: buildCustomExpansionTile(
                  isExpandedList[index] ? 'Create Event' : 'Event Created',
                  '${brideControllers[0].text} weds ${groomControllers[0].text}',
                  index,
                  [buildCreateEvent()],
                  Key(index.toString()),
                ),
              );
            } else if (index == 1) {
              return buildCustomExpansionTile(
                'Bride & Groom Details',
                'Bride & Groom family details added',
                index,
                [buildBrideAndGroom()],
                Key(index.toString()),
              );
            } else if (index == 2) {
              return buildCustomExpansionTile(
                isCompletedList[index] && !isExpandedList[index]
                    ? '${eventList.length} Events Added'
                    : 'Event Details',
                eventFormat(),
                index,
                [buildAddEvents()],
                Key(index.toString()),
              );
            }
          },
        )),
        bottomNavigationBar: _buildNavigationButtonsRow(),
      ),
    );
  }

  /// End of Widget build Function

  /// Expansion Tile
  Widget buildCustomExpansionTile(
    String title,
    String description,
    int index,
    List<Widget> children,
    Key key,
  ) {
    bool isCurrentStep = index == currentPage;
    bool isPreviousStep = index < currentPage;
    bool isCompleted = isCompletedList[index];

    return Padding(
      padding: !isExpandedList[index]
          ? EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0)
          : EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isExpandedList[index] ? Colors.white : Colors.grey[50],
                border: Border.all(
                  color:
                      isExpandedList[index] ? Colors.white : Colors.grey[300]!,
                )),
            child: ExpansionTile(
              key: key,
              controller: expansionControllers[index],
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: isExpandedList[index],
              maintainState: true,
              enabled:
                  isCurrentStep || isPreviousStep || isCompletedList[index],
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 16.0, left: 12),
                        child: !isCompleted
                            ? !isExpandedList[index]
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isExpandedList[index]
                                            ? Colors.white
                                            : Colors.grey[300]!, // Border color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}.",
                                          style:
                                              CustomTextStyles.bodyLargePrimary,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                            : Container(
                                padding: isExpandedList[index]
                                    ? EdgeInsets.only(right: 16.0, left: 12)
                                    : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4E9459),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    PhosphorIcons.check(),
                                    size: 22.h,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            !isCompleted
                                ? isExpandedList[index]
                                    ? '${index + 1}. $title'
                                    : title
                                : title,
                            style: isExpandedList[index]
                                ? CustomTextStyles.bodyLargePrimary
                                : TextStyle(
                                    color: Color.fromRGBO(135, 135, 135, 1),
                                  ),
                          ),
                          if (!isExpandedList[index] && isCompleted)
                            Text(
                              description,
                              style:
                                  TextStyle(fontSize: 11.0, color: Colors.grey),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(16.0),
                child: !isCompletedList[index]
                    ? null
                    : Icon(
                        isExpandedList[index]
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: isExpandedList[index]
                            ? theme.colorScheme.primary
                            : Colors.grey,
                      ),
              ),
              onExpansionChanged: (expanded) {
                // if (!isCurrentStep && !isPreviousStep) return;

                setState(() {
                  // First, handle the clicked tile's state
                  isExpandedList[index] = expanded;

                  // Then, if we're expanding this tile, collapse all others
                  if (expanded) {
                    for (int i = 0; i < isExpandedList.length; i++) {
                      if (i != index && isExpandedList[i]) {
                        isExpandedList[i] = false;
                        expansionControllers[i].collapse();
                      }
                    }

                    currentPage = index;
                  }
                });
              },
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  /// End of Expansion Tile

// Song and Caricature

// Add Events

  /// Build Add Events Widget
  Widget buildAddEvents() {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 14.h,
            right: 14.h,
          ),
          child: Column(
            children: [
              eventList.isNotEmpty
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: 18.h,
                        right: 24.h,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.h,
                            child: Column(
                              spacing: 44,
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  child: VerticalDivider(
                                    width: 2.h,
                                    thickness: 2.h,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: VerticalDivider(
                                    width: 2.h,
                                    thickness: 2.h,
                                    color: theme.colorScheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: eventList.map((event) {
                                // Extract data from the map
                                String eventName =
                                    event['name'] ?? 'Event Name';
                                String eventDate =
                                    event['date'] ?? 'Event Date';
                                String eventVenue =
                                    event['details'] ?? 'Event Venue';

                                return Container(
                                  margin: EdgeInsets.only(bottom: 28),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Color(0xFF4E9459),
                                              width: 2))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 19.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          eventName,
                                          style: CustomTextStyles.bodyLarge18,
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          eventDate,
                                          style: CustomTextStyles
                                              .bodyMediumRobotoBluegray400,
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          eventVenue,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .bodyMediumRobotoBluegray400
                                              .copyWith(
                                            height: 1.31,
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        SizedBox(
                                          width: double.maxFinite,
                                          child: Row(
                                            children: [
                                              CustomIconButton(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  onTap: () {
                                                    setState(() {
                                                      eventList.remove(event);
                                                    });
                                                  },
                                                  padding: EdgeInsets.all(10.h),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 0, 0, 0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                      PhosphorIcons.trash(),
                                                      size: 20.h,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 200, 4, 4))),
                                              SizedBox(
                                                width: 34.h,
                                              ),
                                              CustomIconButton(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  onTap: () {
                                                    setState(() {
                                                      isEdit = true;
                                                      isSelect = false;
                                                      eventControllers[0].text =
                                                          event['name'] ??
                                                              'Event Name';
                                                      eventControllers[1].text =
                                                          event['date'] ??
                                                              'Event Date';
                                                      // Remove 'Venue: ' prefix from the details when setting the controller
                                                      eventControllers[2].text =
                                                          (event['details']!)
                                                              .replaceAll(
                                                                  'Venue - ',
                                                                  '');
                                                    });
                                                    // Open the bottom sheet with the event data for editing
                                                    showEventBottomSheet(
                                                        context, event);
                                                  },
                                                  padding: EdgeInsets.all(8.h),
                                                  decoration:
                                                      IconButtonStyleHelper
                                                          .fillPrimary,
                                                  child: Icon(
                                                    PhosphorIcons
                                                        .pencilSimpleLine(),
                                                    size: 21.h,
                                                    color: Color(0xFF4E9459),
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10.h,
                                                  right: 136.h,
                                                ),
                                                child: Text(
                                                  "Edit",
                                                  style: CustomTextStyles
                                                      .bodyMediumRobotoPrimary,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              eventList.isNotEmpty ? SizedBox(height: 24.h) : Container(),
              CustomOutlinedButton(
                width: 136.h,
                text: "Add event",
                onPressed: () {
                  if (eventList.length < 4) {
                    setState(() {
                      isEdit = false;
                      isSelect = true;
                      eventControllers[0].clear();
                      eventControllers[1].clear();
                      eventControllers[2].clear();
                    });
                    showEventBottomSheet(context, {});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Update or delete Events!'),
                      ),
                    );
                  }
                },
                leftIcon: Container(
                    margin: EdgeInsets.only(right: 6.h),
                    child: Icon(
                      PhosphorIcons.plusCircle(),
                      size: 22.h,
                      color: Color.fromRGBO(114, 114, 114, 0.72),
                    )),
                buttonStyle: CustomButtonStyles.outlineGray,
                buttonTextStyle: CustomTextStyles.bodyMediumGray600,
              ),
              SizedBox(height: 18.h)
            ],
          ),
        ),
      ),
    );
  }

  /// Build Add Events Widget

  /// Function to show bottom sheet with floating close button
  void showEventBottomSheet(BuildContext context, Map<String, String> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Sheet Content
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 20.h), // Add margin for close button
              child: buildEventsBottomSheet(event),
            ),
          ),
          // Floating Close Button
          Positioned(
            top: -40.h,
            right: 20.h,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close,
                  size: 20.h,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to show bottom sheet with floating close button

  /// Original bottom sheet widget without the close button
  Widget buildEventsBottomSheet(Map<String, String> events) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setSheetState) {
        return Container(
          width: double.maxFinite,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 44.h,
            right: 44.h,
            top: 26.h,
          ),
          decoration: AppDecoration.fillOnPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child:_buildEventFormView(context, events),
        );
      },
    );
  }


  /// Widget build Event Form View
  Widget _buildEventFormView(BuildContext context, Map<String, String> events) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 6.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEdit ? "Edit Event Details" : "Add Event Details",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 36.h),
                  _buildFormFields(context),
                  SizedBox(height: 36.h),
                  _buildSubmitButton(context, events),
                  SizedBox(height: 46.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///End of Widget build Event Form View

  /// Widget build Form Fields View
  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: eventControllers[0],
          languageCode: languageCode[selectedLang]!,
          hintText: "Event name",
          maxLines: 1,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 14.h,
          ),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL10,
          fillColor: appTheme.gray5001,
        ),
        SizedBox(height: 26.h),
        CustomTextFormField(
          controller: eventControllers[1],
          hintText: "Event Date & Time",
          languageCode: 'en',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 14.h,
          ),
          readOnly: true,
          focusNode: dateFocusNode,
          onTap: () => pickDateTime(context),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL10,
          fillColor: appTheme.gray5001,
        ),
        SizedBox(height: 26.h),
        CustomTextFormField(
          controller: eventControllers[2],
          languageCode: languageCode[selectedLang]!,
          hintText: "Event Venue",
          textInputAction: TextInputAction.newline,
          textInputType: TextInputType.multiline,
          maxLines: null, // This allows the field to grow with the content
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 14.h,
          ),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL10,
          fillColor: appTheme.gray5001,
        ),
      ],
    );
  }

  /// Widget build Form Fields View

  /// Widget build Submit Button View
  Widget _buildSubmitButton(BuildContext context, Map<String, String> events) {
    return CustomOutlinedButton(
      text: isEdit ? "Update Event" : "Add Event",
      onPressed: () => _handleSubmit(context, events),
      margin: EdgeInsets.symmetric(horizontal: 74.h),
      buttonStyle: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF4E9459),
          side: BorderSide(
            color: appTheme.blueGray10003,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      rightIcon: Container(
          margin: EdgeInsets.only(left: 8.h),
          child: Icon(
            PhosphorIcons.arrowCircleRight(),
            size: 24.0,
            color: Colors.white,
          )),
    );
  }

  /// Widget build Submit Button View

  /// Function to handle Submit of events bottom sheet
  void _handleSubmit(BuildContext context, Map<String, String> events) {
    if (eventControllers[0].text.isNotEmpty &&
        eventControllers[1].text.isNotEmpty &&
        eventControllers[2].text.isNotEmpty &&
        eventList.length < 4) {
      setState(() {
        final event = {
          'name': eventControllers[0].text,
          'date': eventControllers[1].text,
          'details': 'Venue - ${eventControllers[2].text}',
        };

        if (isEdit) {
          int index = eventList.indexWhere((element) => element == events);
          if (index != -1) {
            eventList[index] = event;
          }
        } else {
          eventList.add(event);
        }

        // Clear the controllers after adding/updating
        eventControllers[0].clear();
        eventControllers[1].clear();
        eventControllers[2].clear();
      });

      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('All fields are required!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  ///End of Function to handle Submit of events bottom sheet

// End of Add Events

// Bride and Groom

  /// Birde and Groom Widget
  Widget buildBrideAndGroom() {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 42.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.brideImage,
                      height: 40.h,
                      width: 40.h,
                      radius: BorderRadius.circular(
                        20.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Text(
                        "Bride’s Details",
                        style: CustomTextStyles.bodyLargeGray50003,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              _buildBrideParentsRow(),
              SizedBox(height: 16.h),
              _buildBrideGrandparentsRow(),
              SizedBox(height: 52.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 42.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.groomImage,
                      height: 40.h,
                      width: 40.h,
                      radius: BorderRadius.circular(
                        20.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Text(
                        "Groom’s Details",
                        style: CustomTextStyles.bodyLargeGray50003,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              _buildGroomParentsRow(context),
              SizedBox(height: 16.h),
              _buildGroomGrandparentsRow(context),
              SizedBox(height: 48.h),
              // _buildEventDetailsRow(context)
            ],
          ),
        ),
      ),
    );
  }

  ///End of Bride and Groom Widget

  /// WIdget for Name Input
  Widget _buildNameInput(String hint, TextEditingController controller) {
    return Expanded(
      child: CustomTextFormField(
        controller: controller,
        languageCode: languageCode[selectedLang]!,
        hintText: hint,
        maxLines: 1,
        contentPadding: EdgeInsets.all(15.h),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL10,
        fillColor: appTheme.gray5001,
      ),
    );
  }

  ///End of WIdget for Name Input

  /// Widget for Birde and Parents Row
  Widget _buildBrideParentsRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        children: [
          _buildNameInput("Mother's Name", brideControllers[1]),
          SizedBox(
            width: 12,
          ),
          _buildNameInput("Father's Name", brideControllers[2]),
        ],
      ),
    );
  }

  ///End of Widget for Birde and Parents Row

  /// Build Bride GrandParents Row
  Widget _buildBrideGrandparentsRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 18.h,
      ),
      child: Row(
        children: [
          _buildNameInput("Grandmother's Name", brideControllers[3]),
          SizedBox(
            width: 12,
          ),
          _buildNameInput("Grandfather's Name", brideControllers[4]),
        ],
      ),
    );
  }

  /// End of bride Grand parents row

  /// Build Groom Parents Row
  Widget _buildGroomParentsRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        children: [
          _buildNameInput("Mother's Name", groomControllers[1]),
          SizedBox(
            width: 12,
          ),
          _buildNameInput("Father's Name", groomControllers[2]),
        ],
      ),
    );
  }

  /// Build Groom Parents Row

  /// build Groom Grand parents Row
  Widget _buildGroomGrandparentsRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 18.h,
      ),
      child: Row(
        children: [
          _buildNameInput("Grandmother's Name", groomControllers[3]),
          SizedBox(
            width: 12,
          ),
          _buildNameInput("Grandfather's Name", groomControllers[4]),
        ],
      ),
    );
  }

  /// build Groom Grand parents Row

// End of Groom and Bride

// Create Event

  /// Widget Build Create Events
  Widget buildCreateEvent() {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 18.h),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 36.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Card Language",
                      style: theme.textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 46.h),
                      child: Text(
                        "Wedding Date",
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              _buildLangAndDate(context),
              SizedBox(height: 8.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 46.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Groom Name",
                      style: theme.textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 56.h),
                      child: Text(
                        "Bride Name",
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              _buildNameInputRow(context),
              SizedBox(height: 28.h),
              _buildChooseSideColumn(context),
              SizedBox(height: 54.h),
            ],
          ),
        ),
      ),
    );
  }

  ///End of Widget Build Create Events
  Widget _buildLangAndDate(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(horizontal: 36.h),
    child: Form(
      key: _langAndDateKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedLang,
                        items: languageCode.keys.map((String lang) {
                          return DropdownMenuItem<String>(
                            value: lang,
                            child: Text(
                              lang,
                              style: CustomTextStyles.bodyMediumPrimary,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLang = newValue;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100], // Set background color
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 12),
                          hintText: "Select Language",
                          hintStyle: CustomTextStyles.bodyMediumPrimary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 223, 218, 218), // Green border color
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 223, 218, 218), // Green border color (default)
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(
                                  0xFF4E9459), // Green border when focused
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                        icon: SizedBox.shrink(), // Hide default dropdown icon
                      ),
                      Positioned(
                        right: 10, // Adjust arrow position
                        child: PhosphorIcon(
                            PhosphorIcons.caretDown(),
                            color: Color(0xFF4E9459),
                            size: 18.h,
                          ) // Custom arrow
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: weddingDateController,
                  hintText: "12 June 2024",
                  languageCode: 'en',
                  maxLines: 1,
                  readOnly: true,
                  prefix: PhosphorIcon(
                    PhosphorIcons.calendarHeart(),
                    size: 24.h,
                    color: Color.fromRGBO(153, 153, 153, 1),
                  ),
                  hintStyle: CustomTextStyles.bodySmallGray50002,
                  textInputAction: TextInputAction.done,
                  contentPadding: EdgeInsets.all(12.h),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF4E9459), // Green theme
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    setState(() {
                      weddingDateController.text = pickedDate != null
                          ? DateFormat('dd MMM yyyy').format(pickedDate)
                          : '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  ///Widget build Name Input Row
  Widget _buildNameInputRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal: 36.h,
      ),
      child: Form(
        key: _brideAndGroomKey,
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items from the top
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: groomControllers[0],
                    hintText: "Groom Name",
                    languageCode: languageCode[selectedLang]!,
                    maxLines: 1,
                    hintStyle: CustomTextStyles.bodySmallGray50002,
                    contentPadding: EdgeInsets.all(15.h),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h), // Consistent spacing using .h
                ],
              ),
            ),
            SizedBox(width: 12.h), // Consistent spacing
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: brideControllers[0],
                    hintText: "Bride Name",
                    languageCode: languageCode[selectedLang]!,
                    maxLines: 1,
                    hintStyle: CustomTextStyles.bodySmallGray50002,
                    textInputAction: TextInputAction.done,
                    contentPadding: EdgeInsets.all(15.h),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h), // Consistent spacing using .h
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///Widget build Name Input Row

  /// Widget Build Choose Side Column
  Widget _buildChooseSideColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 38.h,
        right: 30.h,
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "Choose Your Side",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      side = 'Groom';
                    });
                  },
                  child: Container(
                    width: 134.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 6.h,
                    ),
                    decoration: side == 'Bride'
                        ? AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                          )
                        : AppDecoration.outlinePrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                          ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.groomImage,
                          height: 36.h,
                          width: 36.h,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Ladke \nWale",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: side == 'Bride'
                              ? theme.textTheme.bodyMedium!.copyWith(
                                  height: 1.36,
                                )
                              : CustomTextStyles.bodyMediumPrimary.copyWith(
                                  height: 1.36,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "or",
                  style: CustomTextStyles.bodyLargePoppinsGray50001,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      side = 'Bride';
                    });
                  },
                  child: Container(
                    width: 134.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 6.h,
                    ),
                    decoration: side == 'Groom'
                        ? AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                          )
                        : AppDecoration.outlinePrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                          ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.brideImage,
                          height: 36.h,
                          width: 36.h,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Ladki\nWale",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: side == 'Groom'
                              ? theme.textTheme.bodyMedium!.copyWith(
                                  height: 1.36,
                                )
                              : CustomTextStyles.bodyMediumPrimary.copyWith(
                                  height: 1.36,
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///End of Widget Build Choose Side Column

// End of Create Event

// Bottom Navigation

  /// Widget build Navigation Buttons Row
  Widget _buildNavigationButtonsRow() {
    return Container(
      height: 100.h,
      decoration: AppDecoration.outlineGray400,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildSkipButton(context), _buildNextButton(context)],
          ),
        ],
      ),
    );
  }

  /// Widget build Navigation Buttons Row

  /// Widget build Skip Button
  Widget _buildSkipButton(BuildContext context) {
    return currentPage != 0
        ? CustomOutlinedButton(
            width: 116.h,
            text: "Skip",
            onPressed: () {
              if (currentPage <= 2) {
                setState(() {
                  // Mark current step as completed
                  isCompletedList[currentPage] = true;
                  // Collapse current step
                  isExpandedList[currentPage] = false;
                  expansionControllers[currentPage].collapse();
                  if (currentPage == 1) {
                    groomControllers[1].text = 'Groom Mother';
                    groomControllers[2].text = 'Groom Father';
                    groomControllers[3].text = 'Groom GrandMother';
                    groomControllers[4].text = 'Groom GrandFather';
                    brideControllers[1].text = 'Bride Mother';
                    brideControllers[2].text = 'Bride Father';
                    brideControllers[3].text = 'Bride GrandMother';
                    brideControllers[4].text = 'Bride GrandFather';
                  }

                  // Move to next step
                  currentPage++;
                  // Expand next step
                  if (currentPage <= 2) {
                    isExpandedList[currentPage] = true;
                    expansionControllers[currentPage].expand();
                  }
                });
              }
            },
            margin: EdgeInsets.only(left: 4.h),
            buttonStyle: CustomButtonStyles.outlineGray,
            buttonTextStyle: CustomTextStyles.bodyMediumGray600,
          )
        : Container(
            width: 116.h,
          );
  }

  ///End of Widget build Skip Button

  /// Widget Build Next Button
  Widget _buildNextButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 116.h,
      buttonStyle:  OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF4E9459),
          side: BorderSide(
            color: appTheme.blueGray10003,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      text: "Next",
      onPressed: () {
        if ((currentPage == 0 && _brideAndGroomKey.currentState!.validate()) ||
            (currentPage == 1 &&
                ((brideControllers[1].text.isNotEmpty &&
                        brideControllers[2].text.isNotEmpty &&
                        groomControllers[1].text.isNotEmpty &&
                        groomControllers[2].text.isNotEmpty) ||
                    isCompletedList[currentPage])) ||
            (currentPage == 2 &&
                (eventList.isNotEmpty || isCompletedList[currentPage]))) {
          setState(() {
            // Mark current step as completed
            isCompletedList[currentPage] = true;
            // Collapse current step
            isExpandedList[currentPage] = false;
            expansionControllers[currentPage].collapse();

            if (currentPage == 2) {
              String encodedEventList = jsonEncode(eventList);
              Map<String, dynamic> formData = {
                'groomName': groomControllers[0].text,
                'brideName': brideControllers[0].text,
                'side': side,
                'groomMother': groomControllers[1].text,
                'groomFather': groomControllers[2].text,
                'groomGrandmother': groomControllers[3].text,
                'groomGrandfather': groomControllers[4].text,
                'brideMother': brideControllers[1].text,
                'brideFather': brideControllers[2].text,
                'brideGrandmother': brideControllers[3].text,
                'brideGrandfather': brideControllers[4].text,
                'weddingDate':weddingDateController.text,
                'language': selectedLang,
                'events': encodedEventList, // Store encoded string for `events`
              };

              data = formData;

              saveData(formData);
            }
            // Move to next step
            currentPage++;
            // Expand next step
            if (currentPage <= 2) {
              isExpandedList[currentPage] = true;
              expansionControllers[currentPage].expand();
            }
          });
        } else if (currentPage == 3) {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(currentPage == 0
                    ? 'Both Bride And Groom name required'
                    : (currentPage == 1 && !isCompletedList[currentPage])
                        ? 'Both Bride and Groom Father and Mother name required'
                        : (currentPage == 2 && !isCompletedList[currentPage]
                            ? 'Event List Cannot be empty'
                            : ''))),
          );
        }
      },
      rightIcon: Container(
          margin: EdgeInsets.only(left: 6.h),
          child: Icon(
            PhosphorIcons.arrowCircleRight(),
            size: 22.h,
            color: Colors.white,
          )),
    );
  }

  /// Widget Build Next Button

// End of Bottom Navigation
}

// End of Statefull Widget Fill Form

