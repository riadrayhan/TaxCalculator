import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tax_calculator/pdfview.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {

  double income = 0.0;
  double house_tax = 0.0;
  double car_tax = 0.0;
  double income_tax= 0.0;
  double lab_tax= 0.0;
  double roller_tax= 0.0;

  double total_salary= 0.0;
  double d_bill= 0.0;
  double resets=0.0;


  TextEditingController HouseController=TextEditingController();
  TextEditingController CarController=TextEditingController();
  TextEditingController IncomeController=TextEditingController();
  TextEditingController LabController=TextEditingController();
  TextEditingController RollerController=TextEditingController();

  final pdf = pw.Document();

  Future<void> generatePdf() async {
    if (await Permission.storage.request().isGranted) {
      final folderName = 'MyFolder';
      final directory = await getExternalStorageDirectory();
      final folderPath = '${directory?.path}/$folderName';

      // Create the folder if it doesn't exist
      final folder = Directory(folderPath);
      if (!(await folder.exists())) {
        await folder.create(recursive: true);
        print('Folder created at: $folderPath');
      } else {
        print('Folder already exists at: $folderPath');
      }


      final file = File('$folderPath/tax.pdf');

      String budget=income.toString();

      String house = HouseController.text;
      String house1=house_tax.toString();

      String car = CarController.text;
      String car1=house_tax.toString();

      String incomeC = IncomeController.text;
      String incomeT=house_tax.toString();

      String lab = LabController.text;
      String lab1=house_tax.toString();


      String roller = RollerController.text;
      String roller1=house_tax.toString();

      String bill=d_bill.toString();
      String total=total_salary.toString();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                   pw.Text("Budget  "+ budget,style: pw.TextStyle(fontSize: 25,fontWeight: pw.FontWeight.bold)),
                pw.Row(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text("House Tax",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(house+"%",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(house1,style: pw.TextStyle(fontSize: 20))),
                    ]
                ),
                //=====first row end=========//
                pw.Row(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text("Car Tax",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(car+"%",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(car1,style: pw.TextStyle(fontSize: 20))),
                    ]
                ),
                //=====second row end=========//
                pw.Row(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text("Income Tax",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(incomeC+"%",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(incomeT,style: pw.TextStyle(fontSize: 20))),
                    ]
                ),
                //=====third row end=========//
                pw.Row(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text("Lab Test",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(lab,style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(lab1,style: pw.TextStyle(fontSize: 20))),
                    ]
                ),
                //=====fourth row end=========//
                pw.Row(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text("Roller Rent",style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(roller,style: pw.TextStyle(fontSize: 20))),
                      pw.Padding(padding: pw.EdgeInsets.all(20),child: pw.Text(roller1,style: pw.TextStyle(fontSize: 20))),
                    ]
                ),
                //=====fifth row end=========//
                pw.SizedBox(height: 20),
                pw.Text("Deduction Bill: "+bill,style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold)),
                pw.Text("Total Salary: "+total,style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold)),
              ]
            );
          },
        ),
      );

      final Uint8List pdfBytes = await pdf.save();
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved at $folderPath/tax.pdf'),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tax Calculator",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xda0a2362),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerPage(),));
            }, icon: Icon(Icons.book_outlined,color: Colors.white,)),
          )
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 200,
                  decoration:BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: Lottie.asset("assets/calc.json"),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 160,left: 26),
                  child: Card(
                    child:TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          income = double.tryParse(value) ?? 0.0;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your income',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                //=======House tax start=======//
                Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 120,
                        child:Text("House Tax"),
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 70,
                        color: Color(0x54CB8BEC),
                        child: TextField(
                          controller: HouseController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tax %'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepOrange[100],
                          child:Text(' $house_tax ', style: TextStyle(fontSize: 20),),
                        ),
                      )
                    ],
                  ),
                ),
                //=======House tax start=======//
                //======Car Tax start========//
                Card(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                          margin: EdgeInsets.only(left: 8),
                        child:Text("Car Tax")
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 70,
                        color: Color(0x54CB8BEC),
                        child: TextField(
                          controller: CarController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tax %'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepOrange[100],
                          child:Text(' $car_tax ', style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ],
                  ),
                ),
                //======Car Tax end========//
                //======Income Tax start========//
                Card(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                          margin: EdgeInsets.only(left: 8),
                        child:Text("Income Tax")
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 70,
                        color: Color(0x54CB8BEC),
                        child: TextField(
                          controller: IncomeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tax %'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepOrange[100],
                          child:Text(' $income_tax ', style: TextStyle(fontSize: 20),),
                        ),
                      )
                    ],
                  ),
                ),
                //======Income Tax end========//
                //======lab test start========//
                Card(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                          margin: EdgeInsets.only(left: 8),
                        child:Text("Lab Test")
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 70,
                        color: Color(0x54CB8BEC),
                        child: TextField(
                          controller: LabController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tk'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepOrange[100],
                          child:Text(' $lab_tax ', style: TextStyle(fontSize: 20),),
                        ),
                      )
                    ],
                  ),
                ),
                //======lab test end========//
                //======Roller rent start========//
                Card(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                          margin: EdgeInsets.only(left: 8),
                        child:Text("Roller Rent")
                      ),
                      SizedBox(width: 2,),
                      Container(
                        width: 70,
                        color: Color(0x54CB8BEC),
                        child: TextField(
                          controller: RollerController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tk'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepOrange[100],
                          child:Text(' $roller_tax ', style: TextStyle(fontSize: 20),),
                        ),
                      )
                    ],
                  ),
                ),
                //======Roller rent end========//
                Text('Deduction Bill: $d_bill', style: TextStyle(fontSize: 20),),
                //=====================//
                SizedBox(height: 10),
                Text('Total Salary : $total_salary ', style: TextStyle(fontSize: 20),),
                SizedBox(height: 16),
                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 15),
                      child: Container(
                        child: ElevatedButton(onPressed: () {
                         setState(() {
                           reset();
                         });

                        }, child: Text("Reset")),
                      ),
                    ),
                    //========================//
                    ElevatedButton(
                      onPressed: () {
                        House_calculateTax();
                        Car_calculationTax();
                        Lab_calculationTax();
                        Income_calculationTax();
                        Roller_calculationTax();
                        total();
                        deduction_bill();
                        generatePdf();
                      },
                      child: Text(' Tax Calculation',style: TextStyle(fontSize: 15,wordSpacing: 2),),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      )
    );
  }

  void House_calculateTax() {
    double taxpercent=double.tryParse(HouseController.text)?? 0.0;
    house_tax = income * (taxpercent/100);
    setState(() {});
  }

  void Car_calculationTax() {
    double taxpercent=double.tryParse(CarController.text)?? 0.0;
    car_tax = income * (taxpercent/100);
    setState(() {});
  }

  void Income_calculationTax() {
    double taxpercent=double.tryParse(IncomeController.text)?? 0.0;
    income_tax = income * (taxpercent/100);
    setState(() {});
  }

  void Lab_calculationTax() {
    double taxpercent=double.tryParse(LabController.text)?? 0.0;
    lab_tax = taxpercent;
    setState(() {});
  }
  void Roller_calculationTax() {
    double taxpercent=double.tryParse(RollerController.text)?? 0.0;
    roller_tax = taxpercent;
    setState(() {});
  }


  void total(){
    total_salary=income-(house_tax+car_tax+income_tax+lab_tax+roller_tax);
    setState(() {});
  }

  void deduction_bill(){
    d_bill=house_tax+car_tax+income_tax+lab_tax+roller_tax;
    setState(() {});
  }

  void reset(){
    HouseController.clear();
    CarController.clear();
    LabController.clear();
    IncomeController.clear();
    RollerController.clear();
    income = 0.0;
    house_tax = 0.0;
    car_tax = 0.0;
    income_tax= 0.0;
    lab_tax= 0.0;
    roller_tax= 0.0;
    total_salary= 0.0;
    d_bill= 0.0;
    total_salary=0.0;
    setState(() {});
  }
}

