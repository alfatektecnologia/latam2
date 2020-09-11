import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/times/inicio_sobreaviso2.dart';
import 'package:latam/widgets/reserva_form.dart';

import 'package:latam/widgets/times/termino_sobreaviso2.dart';
import 'package:provider/provider.dart';

class SobreAvisoForm extends StatefulWidget {
  @override
  _SobreAvisoFormState createState() => _SobreAvisoFormState();
}

class _SobreAvisoFormState extends State<SobreAvisoForm> {
  var _radioValue1 = -1;
  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);

    return Card(
      elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Center(
                child: Text(
                  'Acionado para:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffed1650),
                  ),
                ),
              ),
              /* SizedBox(
                height: 8,
              ), */
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioValue1,
                  onChanged: (newValue) {
                    setState(() {
                      _radioValue1 = newValue;
                      Util.tipoAcionamentoSobreaviso = '';//reseto qualquer informação  de acionamento anterior
                      util.setTipoAcionamento('Voo');
                      Util.acionado = '0';
                    });

                    print(newValue);
                  },
                ),
                Text(
                  'Voo',
                  style: new TextStyle(fontSize: 16.0,color: Color(0xff858585),)
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: (newValue) {
                    setState(() {
                      _radioValue1 = newValue;
                      Util.tipoAcionamentoSobreaviso = '';
                      util.setTipoAcionamento('Reserva + voo');
                      Util.acionado = '1';
                    });

                    print(newValue);
                  },
                ),
                Text(
                  'Reserva + voo',
                  style: new TextStyle(color: Color(0xff858585),
                    fontSize: 16.0,
                  ),
                ),
              ]),
              SizedBox(
                height: 8,
              ),
              InicioSobreaviso2(),
              SizedBox(
                height: 8,
              ),
              TerminoSobreaviso2(),
              SizedBox(
                height: 8,
              ),
              Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                  ? ReservaForm()
                  : Container(),
              
            ]),
          ),
    );
  }
}
