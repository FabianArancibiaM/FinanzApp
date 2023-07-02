import 'package:finance_now/shared/selector_object.dart';

class InfoConst {
  final List<SelectorObject> listCategory = [
    SelectorObject(key: '', value: 'Seleccionar'),
    SelectorObject(key: 'SAL', value: 'Salario'),
    SelectorObject(key: 'INV', value: 'Inversion'),
    SelectorObject(key: 'S', value: 'Supermercado'),
    SelectorObject(key: 'D', value: 'Deposito'),
    SelectorObject(key: 'C', value: 'Cuentas mias'),
    SelectorObject(key: 'T', value: 'Tarjeta'),
    SelectorObject(key: 'OCOMP', value: 'Salidas, regalos, etc.'),
    SelectorObject(key: 'OCUEN', value: 'Cuentas de otros'),
  ];

  final List<SelectorObject> listType = [
    SelectorObject(key: '', value: 'Seleccionar'),
    SelectorObject(key: 'A', value: 'Abono'),
    SelectorObject(key: 'D', value: 'Descuento')
  ];
}
