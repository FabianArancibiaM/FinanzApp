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

  // paleta de colores
  // Azul:
  //   Azul principal: #007BFF
  //   Azul claro: #B3E5FC
  //   Azul oscuro: #003E9C
  // Verde:
  //   Verde principal: #00C853
  //   Verde claro: #DCEDC8
  //   Verde oscuro: #007E33
  // Gris:
  //   Gris principal: #757575
  //   Gris claro: #E0E0E0
  //   Gris oscuro: #424242
  // Blanco:
  //   Blanco principal: #FFFFFF
  // Negro:
  //   Negro principal: #000000
}
