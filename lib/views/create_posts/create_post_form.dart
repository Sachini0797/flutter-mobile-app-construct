import 'dart:convert';
import 'dart:io';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construct/consts/colors.dart';
import 'package:construct/views/create_posts/post_preview_screen.dart';
import 'package:construct/views/create_posts/product_model.dart';
import 'package:construct/views/home_screen/home_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_nested/models/multiselect_nested_item.dart';

import '../../custom_widget/app_bar.dart';
import '../../custom_widget/form_theme_helper.dart';


class CreatePostPage extends StatefulWidget {
  String type = 'SALE';
  bool isEdit = false;
  bool isRespondToBR = false;
  // postModel.SinglePostModel? singlePostsModel;
  String? buyerRequest;

  String? category;

  String? requestID;
  CreatePostPage(
      this.type,
      this.isEdit,
      this.isRespondToBR, {
        super.key,
        // this.singlePostsModel,
        this.buyerRequest,
        this.category,
        this.requestID,
      });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreatePostPageState();
  }
}

class _CreatePostPageState extends State<CreatePostPage> {
  final formKey = GlobalKey<FormState>();


  List<String> items = ['Days', 'Weeks'];
  String? selectedItems;
  RxString selectedCategory = "".obs;
  RxBool isSelectedCategory = false.obs;
  RxBool category = false.obs;
  RxBool isSearch = false.obs;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  RxList<String> postImage = (<String>[]).obs;

  String? path;

  void selectImage() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (var element in selectedImages) {
        element.readAsBytes().then((value) {
        });
      }
    }
  }

  void selectImageFromCam() async {
    // final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    final XFile? selectedImages = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 40);
    if (selectedImages != null) {
      selectedImages.readAsBytes().then((value) {
        
      });
    }
  }

  bool checkSale = true;
  bool checkLease = false;
  bool? checkNew = true;
  bool? checkUsed = false;
  bool? csPayment = true;
  bool? directDeal = false;
  bool? checkNA = false;
  bool? selfCollect = true;
  bool? onSiteDelivery = false;
  bool? nonNego = false;

  TextEditingController fromDateinput = TextEditingController();
  TextEditingController toDateinput = TextEditingController();
  var postTitle = TextEditingController();
  var description = TextEditingController();
  var durationNumber = TextEditingController();
  var unitPrice = TextEditingController();
  var quantity = TextEditingController();
  TextEditingController dateTimeRangeCtrl = TextEditingController();

  String? postType;
  String? deliveryType;
  String? pickedFrom;
  String? pickedTo;
  String? dealingMethod;
  Duration? difference;
  int ? duration;
  RxString unit = "".obs;

  Rx<DateTime> initStartDate = DateTime.now().obs;
  Rx<DateTime> initEndDate = DateTime.now().add(const Duration(days: 1)).obs;



  double? earn;

 
  bool checkEdit = false;
  bool checkRespondToBR = false;
  MultiSelectNestedItem? multiSelectNestedItem;
  var dMethod;
  double? enteredUnitPrice;
  int? enteredQuantity;
  @override
  void initState() {
    checkEdit = widget.isEdit;
    super.initState();
  }

  calPlatformFees() {
    double? total_price;
    double? csCharges;
    double? platformFees;
    if (csPayment == true) {
      total_price = ((enteredUnitPrice ?? 0) * (enteredQuantity ?? 0));
      // total_price = ((double.parse(unitPrice.text) ?? 0) * (int.parse(quantity.text) ?? 0)!);
      csCharges = ((total_price * 4) / 100);
      platformFees = csCharges;

      return platformFees.toStringAsFixed(2);

      // earn = (total_price! - platformFees!);
    }
  }

  calForecastedRevenue() {
    double? total_price;
    double? csCharges;
    double? platformFees;
    double? earn;
    double? total_gst;
    double? forcastedRevenue;
    if (csPayment == true) {
      total_price = ((enteredUnitPrice ?? 0) * (enteredQuantity ?? 0));
      // total_price = ((double.parse(unitPrice.text) ?? 0) * (int.parse(quantity.text) ?? 0));
      csCharges = ((total_price * 4) / 100);
      platformFees = csCharges;
      earn = (total_price - platformFees);
      total_gst = ((total_price * 0) / 100);
      forcastedRevenue = earn - total_gst;
      return forcastedRevenue.toStringAsFixed(2);
    } else {
      return "0.00";
    }
  }

  handleDurationPeriod(){
    Duration availabilityPeriod;
    availabilityPeriod = initEndDate.value.add(const Duration(days: 1)).difference(initStartDate.value) ;

    int? leasePeriod = 0;
    if(selectedItems == "Days") {
      leasePeriod = duration;
    } else if (selectedItems == "Weeks"){
      leasePeriod = (duration! * 7);
    }

    if(leasePeriod! > availabilityPeriod.inDays){
      return "Minimum lease period must be \nless than availability period.";
    }

    else {
      return "";
    }
  }



  @override
  Widget build(BuildContext context) {
    final df = DateFormat('MMM dd, yyyy ');
    dateTimeRangeCtrl.text = '${df.format(initStartDate.value)} - ${df.format(initEndDate.value)}';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Create a post", context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                            child: Container(
                              // height: 2000,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.transparent, // Set border color
                                      width: 3.0), // Set border width
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                  boxShadow: [const BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                        child: Text("What would you like to Post?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                    child: Form(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Post Type",
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: CheckboxListTile(
                                                  title: const Text("Sale"),
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  value: checkSale,
                                                  
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkSale = value!;
                                                      checkLease = !value;
                                                      postType = "Sale";
                                                      // if (checkEdit) {
                                                      //   if (widget.singlePostsModel!.data!.singlePostDetail!.category! == "sale") {
                                                      //     checkSale == true;
                                                      //     checkLease == false;
                                                      //   }
                                                      // }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CheckboxListTile(
                                                  title: const Text("Lease"),
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  value: checkLease,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkLease = value!;
                                                      checkSale = !value;
                                                      postType = "Lease";
                                                      // if (checkEdit) {
                                                      //   if (widget.singlePostsModel!.data!.singlePostDetail!.category! == "lease") {
                                                      //     checkLease == true;
                                                      //     checkSale == false;
                                                      //   }
                                                      // }
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),

                                          TextFormField(
                                            controller: postTitle,
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: FormThemeHelper().formTextInputStyle('Post Title' '*', 'Enter the post title'),
                                            onChanged: (String value) {},
                                            validator: (value) {
                                              return value!.isEmpty ? 'Please enter post title' : null;
                                            },
                                          ),

                                          Column(
                                            children: [
                                              const Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                                    child: Text(
                                                      "Upload photos",
                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child: Wrap(
                                                  alignment: WrapAlignment.center,
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  spacing: 8,
                                                  children: <Widget>[
                                                    DottedBorder(
                                                      borderType: BorderType.RRect,
                                                      radius: const Radius.circular(12),
                                                      padding: const EdgeInsets.all(6),
                                                      child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: FloatingActionButton.extended(
                                                                      label: const Text(
                                                                        "BROWSE",
                                                                        style: TextStyle(color: Colors.white),
                                                                      ),
                                                                      icon: const Icon(
                                                                        // <-- Icon
                                                                        Icons.upload,
                                                                        size: 24.0,
                                                                      ),
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                                      elevation: 6,
                                                                      backgroundColor: Colors.red.shade800,
                                                                      onPressed: () {
                                                                        getBottomSheetForBrowse(_BottomSheetForBrowse);
                                                                        // selectImage();
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const Text("Upload only PNG,JPG",
                                                                      style: TextStyle(
                                                                        color: Colors.grey,
                                                                      )),
                                                                  ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                      maxHeight: maxHeight(),
                                                                      minHeight: 10,
                                                                      maxWidth: double.infinity,
                                                                    ),
                                                                    child: GridView.builder(
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1, crossAxisCount: 3, mainAxisSpacing: 3),
                                                                        itemCount: postImage.length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          return Stack(
                                                                            children: [
                                                                              Center(
                                                                                  child: CachedNetworkImage(
                                                                                    height: 100,
                                                                                    width: 100,
                                                                                    fit: BoxFit.contain,
                                                                                    imageUrl: postImage.elementAt(index),
                                                                                  )),
                                                                              Positioned(
                                                                                right: -10,
                                                                                top: -13,
                                                                                child: Container(
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.transparent,
                                                                                    border: Border.all(
                                                                                        color: Colors.transparent, // Set border color
                                                                                        width: 3.0), // Set border width
                                                                                    // Set rounded corner radius
                                                                                    // Make rounded corner of border
                                                                                  ),
                                                                                  child: IconButton(
                                                                                    onPressed: () {
                                                                                      showAlertDialog(context, index);
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      Icons.delete,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: description,
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.multiline,
                                            maxLines: 3,
                                            decoration: FormThemeHelper().formTextInputStyle('Description' '*', 'Enter post description'),
                                            onChanged: (String value) {},
                                            validator: (value) {
                                              return value!.isEmpty ? 'Please enter post description' : null;
                                            },
                                          ),

                                          Obx(() => category.isTrue || selectedCategory.isNotEmpty
                                              ? Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Choose Current Request (Optional)",
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                     
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        child: TextFormField(
                                                          onChanged: (e) {
                                                            // createPostCtrl.search(e);
                                                            // createPostCtrl.getBuyerRequests(page: 1, category: selectedCategory.toString(), call: (d) {});
                                                          },
                                                          decoration: InputDecoration(
                                                            prefixIcon: const Icon(
                                                              Icons.search,
                                                              color: Colors.grey,
                                                              size: 25,
                                                            ),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            labelText: "Search Buyer Request",
                                                            labelStyle: const TextStyle(color: Colors.grey),
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            isDense: true,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                     
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                              : Container()),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          (checkEdit
                                              ? Container()
                                              : Column(
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Dealing method*",
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(" Select at least one", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: CheckboxListTile(
                                                      title: const Text("Construcshare Payment Gateway"),
                                                      controlAffinity: ListTileControlAffinity.leading,
                                                      // enabled: csPayment==null ? true : true,

                                                      value: csPayment,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (directDeal == false) {
                                                            csPayment = true;
                                                          } else {
                                                            csPayment = value;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    child: CheckboxListTile(
                                                      title: const Text("Direct Deal with Buyer"),
                                                      controlAffinity: ListTileControlAffinity.leading,
                                                      value: directDeal,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (csPayment == false) {
                                                            directDeal = true;
                                                          } else {
                                                            directDeal = value;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),

                                          if (checkSale == true)
                                            Column(
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Condition",
                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.start,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: CheckboxListTile(
                                                        title: const Text("New"),
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        value: checkNew,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            checkNew = value!;
                                                            checkUsed = !value;
                                                            // if (checkEdit) {
                                                            //   if (widget.singlePostsModel!.data!.singlePostDetail!.condition! == "New") {
                                                            //     checkNew == true;
                                                            //     checkUsed == false;
                                                            //   }
                                                            // }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: CheckboxListTile(
                                                        title: const Text("Used"),
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        value: checkUsed,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            checkUsed = value!;
                                                            checkNew = !value;
                                                            // if (checkEdit) {
                                                            //   if (widget.singlePostsModel!.data!.singlePostDetail!.condition! == "Used") {
                                                            //     checkUsed == true;
                                                            //     checkNew == false;
                                                            //   }
                                                            // }
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          if (checkLease == true)
                                            Column(
                                              children: <Widget>[
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Availability",
                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.start,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                        child: TextFormField(
                                                          controller: dateTimeRangeCtrl,
                                                          textAlign: TextAlign.start,
                                                          keyboardType: TextInputType.number,
                                                          decoration: FormThemeHelper().formTextInputStyle('To - From', 'Select Date Range'),
                                                          onChanged: (String value) {},
                                                          readOnly: true,
                                                          onTap: () {
                                                            print(dateTimeRangeCtrl.text);
                                                            showDateRangePicker(
                                                                context: context,
                                                                firstDate: checkEdit ? DateTime(2000) : DateTime.now(),
                                                                lastDate: DateTime(2101),
                                                                initialDateRange: DateTimeRange(start: DateTime.now().subtract(Duration(days: DateTime.now().weekday -1)),
                                                                    end: DateTime.now().add(Duration(days: DateTime.now().weekday + 1))))
                                                                .then((value) {
                                                              // createPostCtrl.initStartDate(value!.start);
                                                              // createPostCtrl.initEndDate(value.end);
                                                              // dateTimeRangeCtrl.text = '${df.format(value.start)} - ${df.format(value.end)}';
                                                              // difference = value.end.add(Duration(days: 1)).difference(value.start);
                                                              // print(difference?.inDays);
                                                            });
                                                          },
                                                        ))
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Duration(Minimum Lease Period)",
                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.start,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 3.0),
                                                        child: TextFormField(
                                                          controller: durationNumber,
                                                          enabled: !checkNA!,
                                                          textAlign: TextAlign.start,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: "",
                                                            hintText: "",
                                                            helperText: " ",
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white70)),
                                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.grey)),
                                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                                            errorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.red,
                                                                )),
                                                          ),
                                                          onChanged: (String value) {
                                                            if(value.isNotEmpty) {
                                                              duration = int.parse(value);
                                                            } else {
                                                              duration = 0;
                                                            }
                                                            print(duration);
                                                          },
                                                          validator: (value) {
                                                            if (checkNA == true) {
                                                              return null;
                                                            }
                                                            return value!.isEmpty ? 'Empty' : null;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          DropdownButtonFormField<String>(
                                                            enableFeedback: !checkNA!,
                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white70)),
                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.grey)),
                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                                              errorBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  borderSide: const BorderSide(
                                                                    color: Colors.red,
                                                                  )),
                                                            ),
                                                            value: selectedItems,
                                                            items: items
                                                                .map((item) => DropdownMenuItem<String>(
                                                              enabled: !checkNA!,
                                                              value: item,
                                                              child: Text(item),
                                                            ))
                                                                .toList(),
                                                            onChanged: (item) =>
                                                                setState(
                                                                      () => selectedItems = item,
                                                                ),


                                                          ),
                                                          const Text(" "),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: CheckboxListTile(
                                                        title: const Text("NA"),
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        value: checkNA,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            checkNA = value!;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          Row(
                                              children: [
                                                Obx(() => Text(handleDurationPeriod(), style: const TextStyle(color: Colors.red),))
                                              ]
                                          ),


                                          const Row(
                                            children: [
                                              Text(
                                                "Delivery",
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: CheckboxListTile(
                                                          title: const Text("Self-Collect"),
                                                          controlAffinity: ListTileControlAffinity.leading,
                                                          value: selfCollect,
                                                          onChanged: (bool? value) {
                                                            setState(() {
                                                              selfCollect = value!;
                                                              onSiteDelivery = !value;
                                                              // if (checkEdit) {
                                                              //   if (widget.singlePostsModel!.data!.singlePostDetail!.deliveryType! == "self-collect") {
                                                              //     selfCollect == true;
                                                              //     onSiteDelivery == false;
                                                              //   }
                                                              // }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: CheckboxListTile(
                                                          title: const Text("On-Site-Delivery"),
                                                          controlAffinity: ListTileControlAffinity.leading,
                                                          value: onSiteDelivery,
                                                          onChanged: (bool? value) {
                                                            setState(() {
                                                              onSiteDelivery = value!;
                                                              selfCollect = !value;
                                                              // if (checkEdit) {
                                                              //   if (widget.singlePostsModel!.data!.singlePostDetail!.deliveryType! == "on-site delivery") {
                                                              //     onSiteDelivery == true;
                                                              //     selfCollect == false;
                                                              //   }
                                                              // }
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                                                child: Text(
                                                  "Pricing",
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CheckboxListTile(
                                                  title: const Text("Non-Negotiable"),
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  value: nonNego,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      nonNego = value;
                                                      nonNego == true ? nonNego = value : false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: Row(
                                              children: <Widget>[
                                                (checkLease == true
                                                    ? Expanded(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 3),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller: unitPrice,
                                                                textAlign: TextAlign.start,
                                                                keyboardType: TextInputType.number,
                                                                // decoration: FormThemeHelper().formTextInputStyle(
                                                                //     'Unit Price Per Day'
                                                                //         '*',
                                                                //     'Enter here'),
                                                                decoration: InputDecoration(
                                                                  labelText: "Unit Price Per Day*",
                                                                  hintText: "Enter here",
                                                                  helperText: " ",
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white70)),
                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.grey)),
                                                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                                                  errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.red,
                                                                      )),
                                                                ),
                                                                onChanged: (String value) {
                                                                  setState(() {
                                                                    // if (unitPrice != null) {
                                                                    //   enteredUnitPrice = double.parse(unitPrice.text);
                                                                    // }
                                                                    if (value.isNotEmpty) {
                                                                      if (value.isNum) {
                                                                        double.parse(value);
                                                                        value = unitPrice.text;
                                                                        enteredUnitPrice = double.parse(unitPrice.text);
                                                                      } else {
                                                                        0;
                                                                      }
                                                                    }
                                                                  });
                                                                },
                                                                validator: (value) {
                                                                  return value!.isEmpty ? 'Please enter unit price' : null;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                    : Expanded(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 3),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller: unitPrice,
                                                                textAlign: TextAlign.start,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  labelText: "Unit Price*",
                                                                  hintText: "Enter here",
                                                                  helperText: " ",
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white70)),
                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.grey)),
                                                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                                                  errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.red,
                                                                      )),
                                                                ),
                                                                onChanged: (String value) {
                                                                  setState(() {
                                                                    // if (unitPrice != null) {
                                                                    //   enteredUnitPrice = double.parse(unitPrice.text);
                                                                    // }
                                                                    if (value.isNotEmpty) {
                                                                      if (value.isNum) {
                                                                        double.parse(value);
                                                                        value = unitPrice.text;
                                                                        enteredUnitPrice = double.parse(unitPrice.text);
                                                                      } else {
                                                                        0;
                                                                      }
                                                                    }
                                                                  });
                                                                },
                                                                validator: (value) {
                                                                  return value!.isEmpty ? 'Please enter unit price' : null;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ))),
                                                Expanded(
                                                    child: Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            TextFormField(
                                                              controller: quantity,
                                                              textAlign: TextAlign.start,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                labelText: "Quantity*",
                                                                hintText: "Enter here",
                                                                helperText: " ",
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white70)),
                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.grey)),
                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                                                errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    borderSide: const BorderSide(
                                                                      color: Colors.red,
                                                                    )),
                                                              ),
                                                              onChanged: (String value) {
                                                                setState(() {
                                                                  // if (quantity != null) {
                                                                  //   enteredQuantity = int.parse(quantity.text);
                                                                  // }
                                                                  if (value.isNotEmpty) {
                                                                    if (value.isNum) {
                                                                      double.parse(value);
                                                                      value = quantity.text;
                                                                      enteredQuantity = int.parse(quantity.text);
                                                                    } else {
                                                                      0;
                                                                    }
                                                                  }
                                                                });
                                                              },
                                                              validator: (value) {
                                                                return value!.isEmpty ? 'Please enter quantity' : null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),

                                          (csPayment == true && checkSale == true
                                              ? Container(
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 3),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.all(3.0),
                                                                          child: Text(
                                                                            "Platform Fees",
                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                            textAlign: TextAlign.start,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      Expanded(
                                                          child: Column(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: Text(
                                                                          "SGD " + calPlatformFees().toString(),
                                                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                                          textAlign: TextAlign.end,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: RichText(
                                                          text: TextSpan(
                                                              text: 'Your Forecasted Revenue',
                                                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.underline),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: '\n(including GST if Applicable)',
                                                                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12, decoration: TextDecoration.underline),
                                                                    recognizer: TapGestureRecognizer()..onTap = () {})
                                                              ]),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "SGD " + calForecastedRevenue(),
                                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                              : Container()),
                                          (csPayment == true && checkLease == true
                                              ? Container(
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 3),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.all(3.0),
                                                                          child: Text(
                                                                            "Platform Fees",
                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                            textAlign: TextAlign.start,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      Expanded(
                                                          child: Column(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: Text(
                                                                          "SGD " + calPlatformFees().toString(),
                                                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                                          textAlign: TextAlign.end,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: RichText(
                                                          text: TextSpan(
                                                              text: 'Your Forecasted Revenue',
                                                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.underline),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text: '\n(including GST if Applicable)',
                                                                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12, decoration: TextDecoration.underline),
                                                                    recognizer: TapGestureRecognizer()..onTap = () {})
                                                              ]),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "SGD " + calForecastedRevenue() + "/day",
                                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                              : Container()),

                                          const SizedBox(
                                            height: 20,
                                          ),

                                          //buttons
                                          Container(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                                                                   Expanded(
                                                    child: Obx(() => MaterialButton(
                                                      minWidth: 200,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                                                      elevation: 6,
                                                      onPressed: () {
                                                        if (isDraftYes.isTrue) {
                                                          return;
                                                        }
                                                        final isValidForm = formKey.currentState!.validate();

                                                        if (isValidForm ) {
                                                          ProductDetails productDetails = ProductDetails();
                                                          // productDetails.category = selecteCategory;
                                                          productDetails.postTitle = postTitle.text;
                                                          productDetails.description = description.text;
                                                          productDetails.category = checkSale == true ? "sale" : "lease";
                                                          productDetails.deliveryType = selfCollect == true ? 'self-collect' : 'on-site delivery';
                                                          // productDetails.fromDate = fromDateinput as DateTime;
                                                          // productDetails.toDate = toDateinput as DateTime;
                                                          productDetails.period = durationNumber.text ?? '';
                                                          productDetails.weekOrDays = selectedItems ?? "";
                                                          productDetails.quantity = int.parse(quantity.text);
                                                          productDetails.unitPrice = double.parse(unitPrice.text);
                                                          productDetails.dealingMethod = csPayment! && directDeal!
                                                              ? "both"
                                                              : csPayment!
                                                              ? 'cs_platform'
                                                              : 'direct_deal';
                                                          productDetails.dealingMethod == 'direct_deal' ? 0 :productDetails.platformFee = double.parse(calPlatformFees());
                                                          productDetails.subcategory = selectedCategory.value;
                                                          productDetails.image = postImage.value;
                                                          // productDetails.requestID = selectedRequest.map((element) => element.requestID!).toList();
                                                          productDetails.condition = checkNew == true ? "New" : "Used";
                                                          productDetails.isNonNegotiable = nonNego == true ? true : false;
                                                          productDetails.checkNA = checkNA == true ? true : false;
                                                          Navigator.pop(context);
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPreviewPage(productDetails: productDetails)));
                                                        }
                                                      },
                                                      child: const Text('PROCEED'),
                                                      color: (isDraftYes.isFalse &&
                                                          isSelectedCategory.isTrue &&
                                                          quantity.text.isNotEmpty &&
                                                          postTitle.text.isNotEmpty &&
                                                          description.text.isNotEmpty &&
                                                          unitPrice.text.isNotEmpty)
                                                          ? const Color(0xffE4032F)
                                                          : Colors.grey,
                                                      textColor: Colors.white,
                                                    )),
                                                  ),
                                                      // ),
                                                  const SizedBox(
                                                      width: 5
                                                  ),
                                                  Expanded(
                                                    child: MaterialButton(
                                                      minWidth: 200,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                                                      elevation: 6,
                                                      onPressed: () {
                                                        final isValidForm = formKey.currentState!.validate();

                                                        if (isValidForm && isSelectedCategory.isTrue) {
                                                          getShowBottomSheet(_BuildBottomSheet);
                                                        }
                                                      },
                                                      child: const Text('CANCEL'),
                                                      color: (quantity.text.isNotEmpty && postTitle.text.isNotEmpty && description.text.isNotEmpty && unitPrice.text.isNotEmpty)
                                                          ? const Color(0xffE4032F)
                                                          : Colors.grey,
                                                      textColor: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  
  maxHeight() {
    if ((double.parse((postImage.length).toString())) > 3) {
      return (((MediaQuery.of(context).size.width)) / 3) * 2;
    } else if ((double.parse((postImage.length).toString())) > 6) {
      return (((MediaQuery.of(context).size.width)) / 3) * 3;
    } else {
      return (((MediaQuery.of(context).size.width)) / 3) * 1;
    }
  }

  void showAlertDialog(BuildContext context, int index) {
    Widget okBtn = TextButton(
        onPressed: () {
          postImage.removeAt(index);
        },
        child: const Text("Yes"));
    Widget cancelBtn = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"));

    AlertDialog alert = AlertDialog(
      title: const Text("Warning"),
      content: const Text(
        "Are you sure you want to remove this?",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[okBtn, cancelBtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext buildercontext) {
          return alert;
        });
  }

 
  var dragScrlCtrl = DraggableScrollableController();

  getShowBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.40,
        maxHeight: .40,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl,
        builder: sheet,
        isExpand: true,
        isSafeArea: true,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )));
  }

  RxBool isDraftYes = false.obs;

  Widget _BuildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      elevation: 4,
      shadowColor: const Color.fromARGB(150, 0, 0, 0),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.transparent, // Set border color
                  width: 3.0), // Set border width
              borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
              boxShadow: [const BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
          ),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: Colors.red,
                      size: 60,
                    ),
                    Text(
                      "Would you like to Save this Draft",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Obx(() => MaterialButton(
                minWidth: 200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 6,
                onPressed: () {
                  if (isDraftYes.isTrue) {
                    return;
                  }
                  
                },
                textColor: Colors.white,
                color: isDraftYes.isTrue ? Colors.grey.shade300 : const Color(0xffE4032F),
                child: const Text('YES'),
              )),
              MaterialButton(
                minWidth: 200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 6,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.grey,
                textColor: Colors.white,
                child: const Text('CANCEL'),
              ),
              MaterialButton(
                minWidth: 200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 6,
                onPressed: () {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const HomeScreen(),
                    ),
                        (route) => false, //if you want to disable back feature set to false
                  );
                },
                color: Colors.black,
                textColor: Colors.white,
                child: const Text('NO, BACK TO DASHBOARD'),
              )
            ],
          ),
        ),
      ),
    );
  }

  var dragScrlCtrl1 = DraggableScrollableController();

  getBottomSheetForBrowse(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.25,
        maxHeight: .25,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl1,
        builder: sheet,
        isExpand: true,
        isSafeArea: true,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )));
  }

  Widget _BottomSheetForBrowse(
      BuildContext context,
      ScrollController scrollController2,
      double bottomSheetOffset,
      ) {
    return Material(
      elevation: 4,
      shadowColor: const Color.fromARGB(150, 0, 0, 0),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.transparent, // Set border color
                  width: 3.0), // Set border width
              borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
              boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
          ),
          child: Center(
            child: ListView(
              controller: scrollController2,
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        selectImageFromCam();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.grey)),
                          // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Icon(Icons.camera_alt_rounded, size: 70,color: Colors.grey.shade400,),
                            Stack(
                              children: [
                                _buildCamIcon(48, const Color(0xffe20330)),
                                _buildCamIcon(44, Colors.grey.shade400),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Camera",style: TextStyle(fontSize: 18, color: Colors.grey.shade400, fontWeight: FontWeight.w500),),
                                ])

                          ],
                        ),

                      ),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        selectImage();
                      },

                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.grey)),
                          // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Icon(Icons.image, size: 70,color: Colors.grey.shade400),
                            Stack(
                              children: [
                                _buildBrowseIcon(48, const Color(0xffe20330)),
                                _buildBrowseIcon(44, Colors.grey.shade400),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Browse", style: TextStyle(fontSize: 18, color: Colors.grey.shade400, fontWeight: FontWeight.w500),),
                                ])

                          ],
                        ),

                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),side: const BorderSide(color: Colors.black)),
                      elevation: 6,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      textColor: Colors.black,
                      child: const Text('Cancel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCamIcon(double size, Color color) {
    return Container(
      height: 48,
      width: 48,
      alignment: Alignment.center,
      child: Icon(
        Icons.camera_alt,
        color: color,
        size: size,
      ),
    );
  }Widget _buildBrowseIcon(double size, Color color) {
    return Container(
      height: 48,
      width: 48,
      alignment: Alignment.center,
      child: Icon(
        Icons.image,
        color: color,
        size: size,
      ),
    );
  }
}
