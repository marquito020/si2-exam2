import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app_movil/constants/colors.dart';
import 'package:app_movil/controllers/asistencia_controller.dart';
import 'package:app_movil/controllers/taller_controller.dart';
import 'package:app_movil/models/img_model.dart';
import 'package:app_movil/models/index.dart';
import 'package:app_movil/services/asistencia_service.dart';
import 'package:app_movil/services/img_service.dart';
import 'package:app_movil/services/index.dart';
import 'package:app_movil/services/notificacion_service.dart';
import 'package:app_movil/utils/maps_style.dart';
import 'package:app_movil/widgets/drawer_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:location/location.dart';
import 'package:app_movil/constants/api_google.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder2/geocoder2.dart';

class NotificacionFormWidget extends StatefulWidget {
  const NotificacionFormWidget({Key? key, required this.asistencia})
      : super(key: key);
  final Asistencia asistencia;

  @override
  State<NotificacionFormWidget> createState() => _NotificacionFormWidgetState();
}

class _NotificacionFormWidgetState extends State<NotificacionFormWidget> {
  /* Controlado Mapa */
  final Completer<GoogleMapController> _completer = Completer();

  /* Ubicacion actual */
  LocationData? currentLocation;

  /* Marker */
  Set<Marker> markers = {};

  /* Polylines */
  List<LatLng> polylineCoordinates = [];

  /* Puntos Inicio */
  double origenLatitude = 0;
  double origenLongitude = 0;

  /* Puntos Fin */
  double destinoLatitude = 0;
  double destinoLongitude = 0;

  /* Markers Flotanets */
  bool mostrarMarkerOrigen = false;
  /* bool mostrarMarkerDestino = false; */

  /* Distancia de polynine */
  double totalDistance = 0.0;

  /* Direccion de Marker */
  String address = '';

  /* Direccion lugar Map Origen */
  String addressOrigen = '';

  /* Direccion lugar Map Destino */
  String addressDestino = '';

  /* Coordenadas del marker centro pantalla */
  LatLng? centerMarkerScreen;

  /* Loading Mapa */
  bool isLoading = false;

  Future<GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  _init() async {
    (await _mapController).setMapStyle(jsonEncode(mapStyle));
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((LocationData locationData) async {
      currentLocation = locationData;
      final ByteData imageData =
          await rootBundle.load('assets/icons/mark_start.png');
      final Uint8List bytes = imageData.buffer.asUint8List();
      final img.Image? originalImage = img.decodeImage(bytes);
      final img.Image resizedImage =
          img.copyResize(originalImage!, width: 88, height: 140);
      final resizedImageData = img.encodePng(resizedImage);
      final BitmapDescriptor bitmapDescriptor =
          BitmapDescriptor.fromBytes(resizedImageData);
      final newMarker = Marker(
        markerId: const MarkerId("origen"),
        position: LatLng((widget.asistencia.ubicacion!.x).toDouble(),
            (widget.asistencia.ubicacion!.y).toDouble()),
        icon: bitmapDescriptor,
      );
      origenLatitude = currentLocation!.latitude!;
      origenLongitude = currentLocation!.longitude!;
      markers.add(newMarker);
      address = await getAddressFromMarker(
          currentLocation!.latitude!, currentLocation!.longitude!);
      addressOrigen = address;
      setState(() {});
    });
  }

  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) async {
    final GoogleMapController controller = await _mapController;
    return controller.getLatLng(screenCoordinate);
  }

  void addMarkerOrigen(double latitude, double longitude) async {
    final ByteData imageData =
        await rootBundle.load('assets/icons/mark_start.png');
    final Uint8List bytes = imageData.buffer.asUint8List();
    final img.Image? originalImage = img.decodeImage(bytes);
    final img.Image resizedImage =
        img.copyResize(originalImage!, width: 88, height: 140);
    final resizedImageData = img.encodePng(resizedImage);
    final BitmapDescriptor bitmapDescriptor =
        BitmapDescriptor.fromBytes(resizedImageData);
    final newMarker = Marker(
      markerId: const MarkerId("origen"),
      position: LatLng(latitude, longitude),
      icon: bitmapDescriptor,
    );
    markers.add(newMarker);
    address = await getAddressFromMarker(latitude, longitude);
    addressOrigen = address;
    if (destinoLatitude != 0 && destinoLongitude != 0) {
      createPolylines();
    }
    setState(() {});
  }

  void removeMarker(MarkerId markerId) {
    setState(() {
      markers.removeWhere((marker) => marker.markerId == markerId);
      polylineCoordinates.clear();
    });
  }

  getAddressFromMarker(double latitude, double longitude) async {
    try {
      if (isLoading) {
        setState(() {});
      } else {
        GeoData dataGeo = await Geocoder2.getDataFromCoordinates(
            latitude: latitude,
            longitude: longitude,
            googleMapApiKey: apiGoogle);
        isLoading = false;
        address = dataGeo.address;
        if (kDebugMode) {
          print("Dirección: $address");
        }
        return address;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  getAddressFromLatLng() async {
    try {
      if (isLoading) {
        setState(() {});
      } else {
        GeoData dataGeo = await Geocoder2.getDataFromCoordinates(
            latitude: centerMarkerScreen!.latitude,
            longitude: centerMarkerScreen!.longitude,
            googleMapApiKey: apiGoogle);
        setState(() {
          isLoading = false;
          address = dataGeo.address;
          if (kDebugMode) {
            print("Dirección: $address");
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      setState(() {
        isLoading = true;
      });
    }
  }

  void addMarkerDestino(double latitude, double longitude) async {
    final ByteData imageData =
        await rootBundle.load('assets/icons/mark_end.png');
    final Uint8List bytes = imageData.buffer.asUint8List();
    final img.Image? originalImage = img.decodeImage(bytes);
    final img.Image resizedImage =
        img.copyResize(originalImage!, width: 88, height: 140);
    final resizedImageData = img.encodePng(resizedImage);
    final BitmapDescriptor bitmapDescriptor =
        BitmapDescriptor.fromBytes(resizedImageData);
    final newMarker = Marker(
      markerId: const MarkerId("destino"),
      position: LatLng(latitude, longitude),
      icon: bitmapDescriptor,
    );
    markers.add(newMarker);
    address = await getAddressFromMarker(latitude, longitude);
    addressDestino = address;
    if (origenLatitude != 0 && origenLongitude != 0) {
      createPolylines();
    }
    setState(() {});
  }

  void createPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiGoogle,
      PointLatLng(origenLatitude, origenLongitude),
      PointLatLng(destinoLatitude, destinoLongitude),
    );

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      /* calculatePolylineDistance(polylineCoordinates);
      calculateTime();
      calculatePrice(); */

      // Obtén el GoogleMapController
      GoogleMapController controller = await _mapController;

      // Crea una lista de LatLng que contiene todos los puntos del polyline
      List<LatLng> allPoints = [
        LatLng(origenLatitude, origenLongitude),
        ...polylineCoordinates,
        LatLng(destinoLatitude, destinoLongitude),
      ];

      // Calcula los límites del polyline
      LatLngBounds bounds = boundsFromLatLngList(allPoints);

      // Ajusta la cámara para mostrar los límites del polyline en toda la pantalla
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 130.0),
      );
    }

    setState(() {});
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? minLat, maxLat, minLng, maxLng;

    for (final latLng in list) {
      if (minLat == null || latLng.latitude < minLat) {
        minLat = latLng.latitude;
      }
      if (maxLat == null || latLng.latitude > maxLat) {
        maxLat = latLng.latitude;
      }
      if (minLng == null || latLng.longitude < minLng) {
        minLng = latLng.longitude;
      }
      if (maxLng == null || latLng.longitude > maxLng) {
        maxLng = latLng.longitude;
      }
    }

    return LatLngBounds(
      northeast: LatLng(maxLat!, maxLng!),
      southwest: LatLng(minLat!, minLng!),
    );
  }

  final TextEditingController _searchController = TextEditingController();
  String nombrePerfil = "";
  String nro_registro = "";

  @override
  void initState() {
    _init();
    getCurrentLocation();
    /* cargarDatosStore(); */
    super.initState();
    print(nombrePerfil);
  }

  void cargarDatosStore() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    nombrePerfil = user.getString('nombre')!;
    nro_registro = user.getString('nro_registro')!;
  }

  @override
  void dispose() {
    // Dispose el TextEditingController al finalizar
    _searchController.dispose();
    super.dispose();
  }

  List<Taller> tallerList = [];
  List<Servicio> servicioList = [];
  List<Img> imgList = [];
  List<Img> imgListTaller = [];

  @override
  Widget build(BuildContext context) {
    /* Taller Control and Serices */
    /* final tallerForm = Provider.of<TallerFormController>(context); */
    final tallerService = Provider.of<TallerService>(context, listen: false);
    final asistenciaService =
        Provider.of<NotificacionService>(context, listen: false);
    final asistenciaForm = Provider.of<AsistenciaFormController>(context);
    /* Servicio Service */
    final servicioService =
        Provider.of<ServicioService>(context, listen: false);
    final imgService = Provider.of<ImgService>(context, listen: false);
    if (tallerService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (servicioService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (imgService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    servicioList = servicioService.servicioList;
    tallerList = tallerService.tallerList;
    imgList = imgService.imgList;

    for (var i = 0; i < imgList.length; i++) {
      if (imgList[i].id_asistencia == widget.asistencia.id) {
        imgListTaller.add(imgList[i]);
      }
    }

    for (var i = 0; i < tallerList.length; i++) {
      /* if (tallerList[i].id == widget.asistencia.id_taller) { */
      /* destinoLatitude = tallerList[i].ubicacion!.x.toDouble();
      destinoLongitude = tallerList[i].ubicacion!.y.toDouble(); */
      /* } */
      final newMarker = Marker(
        markerId: MarkerId(tallerList[i].nombre.toString()),
        position: LatLng((tallerList[i].ubicacion!.x).toDouble(),
            (tallerList[i].ubicacion!.y).toDouble()),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: tallerList[i].nombre,
        ),
      );
      markers.add(newMarker);
    }
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(pageNombre: "Notificaciones"),
      ),
      body: Stack(
        children: [
          if (currentLocation == null)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                    zoom: 14.5),
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: false,
                mapType: MapType.normal,
                compassEnabled: false,
                markers: markers,
                onCameraMove: (CameraPosition? position) {
                  if (kDebugMode) {
                    print("Camera Move");
                  }
                  isLoading = false;
                  centerMarkerScreen = position!.target;
                  isLoading = true;
                  getAddressFromLatLng();
                },
                onCameraIdle: () {
                  if (kDebugMode) {
                    print("Camera Idle");
                  }
                  isLoading = false;
                  getAddressFromLatLng();
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('polyLine'),
                    color: Colors.blue,
                    points: polylineCoordinates,
                    width: 5,
                  ),
                },
              ),
            ),
          /* Desplegador "¿Seleccionar taller?" */
          if (mostrarMarkerOrigen == false)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: containerprimaryAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 10),
                        const Text('¿Seleccionar taller?'),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: SizedBox(
                            width: 2,
                            child: Container(
                              color: containerprimaryAccent,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                    onPressed: () {
                      _desplegableOrigenDestino(
                          context,
                          tallerList,
                          asistenciaForm,
                          asistenciaService,
                          servicioList,
                          imgList);
                    },
                  ),
                ),
              ),
            ),
          if (mostrarMarkerOrigen /* || mostrarMarkerDestino */)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Aceptar'),
                          onPressed: () {
                            _completer.future
                                .then((GoogleMapController controller) {
                              controller
                                  .getVisibleRegion()
                                  .then((LatLngBounds bounds) {
                                final LatLng centerLatLng = LatLng(
                                  (bounds.northeast.latitude +
                                          bounds.southwest.latitude) /
                                      2,
                                  (bounds.northeast.longitude +
                                          bounds.southwest.longitude) /
                                      2,
                                );
                                if (mostrarMarkerOrigen) {
                                  origenLatitude = centerLatLng.latitude;
                                  origenLongitude = centerLatLng.longitude;
                                  mostrarMarkerOrigen = false;
                                  addMarkerOrigen(
                                      origenLatitude, origenLongitude);
                                }
                              });
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Cancelar'),
                          onPressed: () {
                            if (mostrarMarkerOrigen) {
                              mostrarMarkerOrigen = false;
                              addMarkerOrigen(origenLatitude, origenLongitude);
                            }
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 10),
            child: Builder(
              builder: (BuildContext context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'open_drawer',
                      backgroundColor: Colors.black54,
                      elevation: 0,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ),

          /* Marker Flotante Origen */
          if (mostrarMarkerOrigen)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 38),
                child: Image.asset(
                  'assets/icons/mark_start.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),

          /* Texto FLotante de Direccion */
          if (mostrarMarkerOrigen)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 110),
                child: Container(
                  color: isLoading ? Colors.transparent : Colors.white,
                  child: isLoading
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitFadingCircle(
                            color: Colors.green,
                            size: 30,
                          ),
                        )
                      : Text(
                          address,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future _desplegableOrigenDestino(
      BuildContext context,
      List<Taller> tallerList,
      AsistenciaFormController asistenciaForm,
      NotificacionService asistenciaService,
      List<Servicio> servicioList,
      List<Img> imgList) {
    String ServicioNombre = servicioList
        .firstWhere((element) => element.id == widget.asistencia.id_servicio)
        .servicio;
    int costo = servicioList
        .firstWhere((element) => element.id == widget.asistencia.id_servicio)
        .precio;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: asistenciaForm.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 56, right: 10),
                          child: SizedBox(
                            height: 1,
                            child: Container(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                    offset: const Offset(0,
                                        15), // Desplazamiento vertical positivo
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: double
                                            .infinity, // MediaQuery.of(context).size.width * 0.1,
                                        /* height:
                                                  MediaQuery.of(context).size.width *
                                                      0.1, */
                                        decoration: const BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        /* DropdownButtonFormField List Servicios */
                                        child: DropdownButtonFormField(
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: containerprimary,
                                          ),
                                          dropdownColor: primary,
                                          decoration: const InputDecoration(
                                            hintText: 'Selecciona un taller',
                                            alignLabelWithHint: true,
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: containerprimary,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: containerprimary,
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            border: InputBorder.none,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                          ),
                                          value: tallerList.isEmpty
                                              ? tallerList[0].id
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              /* tallerList.asistencia.id_servicio =
                                                  value as int; */
                                              asistenciaForm.asistencia
                                                  .id_taller = value as int;
                                            });
                                          },
                                          items: tallerList.map((taller) {
                                            return DropdownMenuItem(
                                              value: taller.id,
                                              child: Text(taller.nombre,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: containerprimary,
                                                  )),
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                  /* Form(
                                    key: tallerForm.formKey,
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width * 0.1,
                                          height:
                                              MediaQuery.of(context).size.width * 0.1,
                                          decoration: const BoxDecoration(
                                            color: primary,
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width *
                                                0.5,
                                            child: TextFormField(
                                              initialValue: addressOrigen,
                                              decoration: const InputDecoration(
                                                hintText: 'Ingresa tu ubicación',
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                ),
                                                labelText: 'Punto de partida',
                                                labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                ),
                                                border: InputBorder.none,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always, // Hace que el labelText sea estático arriba
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  /* searchAddr = value; */
                                                });
                                              },
                                            ),
                                          ),
                                          ButtonBar(
                                            buttonPadding: EdgeInsets
                                                .zero, // Elimina el padding de los botones
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  /* _controller.clear(); */
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(0),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            255, 235, 235, 235)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )),
                                              ),
                                              onPressed: () {
                                                if (origenLatitude != 0 &&
                                                    origenLongitude != 0) {
                                                  removeMarker(
                                                      const MarkerId('origen'));
                                                }
                                                Navigator.pop(context);
                                                setState(() {
                                                  mostrarMarkerOrigen = true;
                                                });
                                              },
                                              child: const Text('Mapa',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                  ))),
                                        ],
                                      ),
                                    ]),
                                  ),
                                   */
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 56, right: 10),
                                    child: SizedBox(
                                      height: 1,
                                      child: Container(
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                  /* Asistencia Nombre */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Nombre del servicio: $ServicioNombre',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  /* Costo */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Costo: $costo',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  /* Costo con el descuento */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Costo con el descuento: ${costo - (costo * 0.1)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  /* Precio */
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double
                                            .infinity, // MediaQuery.of(context).size.width * 0.1,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: const BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        /* TextForm Nombre Taller */
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            /* Solo numero */
                                            keyboardType: TextInputType.number,
                                            initialValue: '',
                                            decoration: const InputDecoration(
                                              hintText: 'Ingresa el precio',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                              /* labelText: 'Nombre del taller', */
                                              labelStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior
                                                      .always, // Hace que el labelText sea estático arriba
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                /* asistenciaForm.asistencia.costo =
                                                    double.parse(value); */
                                                if (value != '') {
                                                  asistenciaForm.asistencia
                                                      .costo = int.parse(value);
                                                } else {
                                                  asistenciaForm
                                                      .asistencia.costo = 0;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      )),

                                  /* Imagenes */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imgListTaller.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.network(
                                                (imgListTaller[index].img)
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  /* Aceptar */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                        ),
                                        child: const Text('Aceptar'),
                                        onPressed: () async {
                                          /* if (tallerForm.isValidForm()) { */
                                          asistenciaForm.isLoading = true;
                                          /* Point tallerUbicacion = tallerList
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  asistenciaForm
                                                      .asistencia.id_taller)
                                              .ubicacion;
                                          print((tallerUbicacion.x).toDouble());
                                          print((tallerUbicacion.y).toDouble());
                                          addMarkerDestino(
                                              (tallerUbicacion.x).toDouble(),
                                              (tallerUbicacion.y.toDouble()));
                                          print(polylineCoordinates); */
                                          asistenciaForm.asistencia.id = widget
                                              .asistencia
                                              .id; // id de asistencia
                                          final response =
                                              await asistenciaService
                                                  .updateAsistencia(
                                            asistenciaForm.asistencia,
                                          );
                                          asistenciaForm.isLoading = false;
                                          if (response) {
                                            Navigator.pushNamed(
                                                context, '/notificaciones');
                                          } else {
                                            // mostrar error
                                            print(response);
                                          }
                                          /* } */
                                        },
                                      ),
                                    ),
                                  ),

                                  /* Nombre Taller */

                                  /* Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double
                                            .infinity, // MediaQuery.of(context).size.width * 0.1,
                                        height:
                                            MediaQuery.of(context).size.width * 0.1,
                                        decoration: const BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                        ),
                                        /* TextForm Nombre Taller */
                                        child: TextFormField(
                                          initialValue: '',
                                          decoration: const InputDecoration(
                                            hintText: 'Ingresa el nombre del taller',
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                            /* labelText: 'Nombre del taller', */
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            floatingLabelBehavior: FloatingLabelBehavior
                                                .always, // Hace que el labelText sea estático arriba
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              tallerForm.taller.nombre = value;
                                            });
                                          },
                                        ),
                                      )),
                                  /* Registrar Taller */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                        ),
                                        child: const Text('Registrar Taller'),
                                        onPressed: () async {
                                          Point point =
                                              Point(origenLatitude, origenLongitude);
                                          tallerForm.taller.ubicacion = point;
                                          /* if (tallerForm.isValidForm()) { */
                                          tallerForm.isLoading = true;
                                          bool response = await tallerService
                                              .registerNewTaller(tallerForm.taller);
                                          tallerForm.isLoading = false;
                                          if (response) {
                                            Navigator.pushNamed(context, '/talleres');
                                          } else {
                                            // mostrar error
                                            print(response);
                                          }
                                          /* } */
                                        },
                                      ),
                                    ),
                                  ), */
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
