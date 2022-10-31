import 'dart:convert';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';
class SelectBlueDevice extends StatefulWidget {
  const SelectBlueDevice({super.key});

  @override
  _SelectBlueDeviceState createState() => _SelectBlueDeviceState();
}

class _SelectBlueDeviceState extends State<SelectBlueDevice> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Printer'),
        ),
        body: SafeArea(
          child: _isLoading && _blueDevices.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )
              : _blueDevices.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: List<Widget>.generate(_blueDevices.length,
                                (int index) {
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _blueDevices[index].address ==
                                              (_selectedDevice?.address ?? '')
                                          ? _onDisconnectDevice
                                          : () => _onSelectDevice(index),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _blueDevices[index].name,
                                              style: TextStyle(
                                                color:
                                                    _selectedDevice?.address ==
                                                            _blueDevices[index]
                                                                .address
                                                        ? Colors.green
                                                        : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              _blueDevices[index].address,
                                              style: TextStyle(
                                                color:
                                                    _selectedDevice?.address ==
                                                            _blueDevices[index]
                                                                .address
                                                        ? Colors.blueGrey
                                                        : Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_loadingAtIndex == index && _isLoading)
                                    Container(
                                      height: 24.0,
                                      width: 24.0,
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.green,
                                        ),
                                      ),
                                    ),
                                  if (!_isLoading &&
                                      _blueDevices[index].address ==
                                          (_selectedDevice?.address ?? ''))
                                    TextButton(
                                      onPressed: _onPrintReceipt,
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.5);
                                            }
                                            return Theme.of(context)
                                                .primaryColor;
                                          },
                                        ),
                                      ),
                                      child: Container(
                                        color: _selectedDevice == null
                                            ? Colors.grey
                                            : Colors.green,
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'Print',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Scan bluetooth device',
                            style: TextStyle(fontSize: 24, color: Colors.green),
                          ),
                          Text(
                            'Press scan button',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isLoading ? null : _onScanPressed,
          backgroundColor: _isLoading ? Colors.grey : Colors.green,
          child: const Icon(Icons.search),
        ),
      
    );
  }
  Future<void> _onScanPressed() async {
    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index) {
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        print('$runtimeType - something wrong');
      }
      setState(() => _isLoading = false);
    });
  }
  Future<void> _onPrintReceipt() async {
    /// Example for Print Image
    final ByteData logoBytes = await rootBundle.load(Images.phoneField);
    /// Example for Print Text
    final ReceiptSectionText receiptText = ReceiptSectionText();
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 150,alignment: ReceiptAlignment.center
    );
    // receiptText.addSpacer();
    // receiptText.addText(
    //   'MY STORE',
    //   size: ReceiptTextSizeType.medium,
    //   style: ReceiptTextStyleType.bold,
    // );
    // receiptText.addText(
    //   'Black White Street, Jakarta, Indonesia',
    //   size: ReceiptTextSizeType.small,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText('Time', '04/06/21, 10:00');
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'Apple 1kg',
    //   'Rp30.000',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.bold,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'TOTAL',
    //   'Rp30.000',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.bold,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'Payment',
    //   'Cash',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.normal,
    // );
    // receiptText.addSpacer(count: 2);

    // await _bluePrintPos.printReceiptText(receiptText);

    /// Example for print QR
    await _bluePrintPos.printQR('KB', size: 250);

    /// Text after QR
    final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    receiptSecondText.addText('Powered by KB',
        size: ReceiptTextSizeType.small);
    receiptSecondText.addSpacer();
    await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  }
}