import '../models/question.dart';

final List<Question> categoriaAQuestions = [
  Question(
    text:
        'La Organización Mundial de la Salud manifiesta que el riesgo en la vía pública surge como resultado de diversos factores, ¿cuáles son?',
    options: [
      'Vehicular y Ambiental',
      'Humano y Vehicular.',
      'Humano, Vehicular y Ambiental.',
    ],
    correctIndices: [2],
  ),
  Question(
    text:
        'Por lo general, las fallas mecánicas se deben a conductas negligentes por parte de los propietarios de los vehículos, que no se ocupan de la verificación del estado de su moto vehículo',
    options: ['Verdadero', 'Falso'],
    correctIndices: [0],
  ),
  Question(
    text:
        'Cada usuario de la vía pública es responsable de una parte del tránsito.” ¿Es correcta ésta premisa?',
    options: [
      'No, porque los que tienen responsabilidad son aquellos que conducen cualquier tipo de vehículo.',
      'No, la responsabilidad la asumen aquellos que obtienen una licencia de conducir.',
      'Sí, porque se está obligado a no causar peligro ni entorpecer la circulación.',
    ],
    correctIndices: [2],
  ),
  Question(
    text: 'Todo usuario de la vía pública debe, como premisa básica:',
    options: [
      'Asumir la obligación de no entorpecer la circulación y no causar peligro, perjuicios o molestias innecesarias a las personas o daños a los bienes.',
      'Acreditar experiencia de manejo en vehículos por más de un año.',
      'Concurrir a cursos de actualización en temática vial, con una frecuencia no mayor a seis meses.',
    ],
    correctIndices: [0],
  ),
  Question(
    text:
        '¿Cuál de las siguientes opciones representa a los usuarios de la vía, ordenados de más a menos vulnerable?',
    options: [
      'Camión - Colectivo - Moto - Ciclista - Peatón - Taxi/Automóvil.',
      'Peatón - Ciclista - Moto - Colectivo - Taxi/Automóvil - Camión.',
      'Peatón - Ciclista - Colectivo - Moto - Taxi/Automóvil - Camión.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        '¿Qué obligaciones impone la ley a aquel conductor que participe de un siniestro?',
    options: [
      'Detenerse inmediatamente, solicitar auxilio para atender a las víctimas si las hubiera y brindar su colaboración para evitar mayores daños para la circulación.',
      'Suministrar sus datos personales, del vehículo, de la licencia de conducir y del seguro obligatorio a los demás siniestrados y a la autoridad interviniente.',
      'Ambas respuestas, A y B, son correctas.',
    ],
    correctIndices: [2],
  ),
  Question(
    text:
        '¿Quién es el responsable civil por un incidente de tránsito producido por un menor de edad poseedor de una licencia de conducir?',
    options: [
      'El que firmó la autorización para obtener la licencia.',
      'El que lo acompaña.',
      'El que le autorizó el uso del vehículo',
    ],
    correctIndices: [0],
  ),
  Question(
    text: '¿Cuánto dura en su totalidad la condición de principiante?',
    options: [
      '2 años, sólo en el caso de los menores de 21 años de edad.',
      '6 meses, sólo para quien la tramita por primera vez.',
      '1 año, independientemente de la edad.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        'Si los datos de la licencia de conducir no coinciden con los datos del DNI:',
    options: [
      'No ocurre absolutamente nada.',
      'La licencia está vigente de todos modos.',
      'La licencia se encuentra caduca. Salvo que no aun este vigente el plazo de gracias de los 90 días.',
    ],
    correctIndices: [2],
  ),
  Question(
    text:
        'Si el conductor de un vehículo se niega a realizar este test de alcoholemia, ¿constituye esto una falta? ',
    options: [
      'Sólo si se ha participado de un siniestro vial.',
      'No. Sólo la prueba positiva, efectivamente realizada, se considera una falta.',
      'Sí, la misma se toma como una presunción de alcoholemia positiva.',
    ],
    correctIndices: [2],
  ),
  Question(
    text:
        '¿cuál es el nivel máximo de alcoholemia admitido para un conductor? ',
    options: [
      '0,5 gramos de alcohol por litro de sangre.',
      '0 gramos de alcohol por litro de sangre.',
      '0,2 gramos de alcohol por litro de sangre.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        'Indique cuales son los 5 factores que afectan las condiciones fisicas al conducir:',
    options: [
      'Uso de calzado inapropiado.',
      'Uso del celular.',
      'El sol.',
      'Bebidas alcohólicas.',
      'Drogas.',
      'Medicamentos.',
      'El frio.',
    ],
    correctIndices: [1, 3, 4, 5],
  ),
  Question(
    text: 'Los datos en consignados en la licencia de Conducir:',
    options: [
      'Todo dato del conductor que se encuentra en la Licencia debe estar actualizado.',
      'Sólo los datos referentes a nombre y domicilio del conductor.',
      'Sólo deben actualizar los datos los conductores profesionales.',
    ],
    correctIndices: [0],
  ),
  Question(
    text:
        'La distancia de seguridad mínima requerida entre vehículos, de todo tipo, que circulan por un mismo carril, es aquélla que resulte prudente teniendo en cuenta la velocidad de marcha y las condiciones de la calzada y del clima, y que resulte de una separación en tiempo de por lo menos 5 (cinco) segundos.',
    options: ['Verdadero.', 'Falso.'],
    correctIndices: [1],
  ),
  Question(
    text: '¿A qué se denomina “Calzada” ?:',
    options: [
      'La vía destinada sólo a la circulación de vehículos.',
      'La vía destinada a circulación de vehículos y peatones.',
      'La vía destinada a circulación de peatones únicamente',
    ],
    correctIndices: [0],
  ),
  Question(
    text: 'Inhabilitados (para conducir) Cumplida la pena: ',
    options: [
      'No podrán acceder a una licencia de cualquier categoría, aquellos conductores que hayan sido inhabilitados o que tengan o hayan sido condenados por causas referidas a accidentes de tránsito',
      'No podrán acceder a una licencia con categoría profesional aquellos conductores que hayan sido inhabilitados o que tengan o hayan sido condenados por causas referidas a accidentes de tránsito, y no hayan transcurrido diez (10) años desde la fecha de vencimiento de la pena impuesta.',
      'No podrán acceder a una licencia aquellos conductores que hayan sido condenados por causas referidas a accidentes de tránsito.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        '¿Qué vehículo tiene prioridad de paso en una intersección de calles de igual jerarquía?:',
    options: [
      'El que llega primero a la intersección.',
      'El que circula por la rotonda.',
      'El que circula desde la derecha.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        'Cuando se ingresa a una rotonda, ¿qué vehículo tiene prioridad de paso?:',
    options: [
      'El que circula desde la derecha.',
      'El que circula por la rotonda.',
      'Depende del porte del vehículo.',
    ],
    correctIndices: [2],
  ),
  Question(
    text: '¿Qué vehículos tienen siempre prioridad de paso?:',
    options: [
      'Ambulancias, policía y bomberos, estén o no en servicio',
      'Ambulancias, policía, bomberos y transporte de personas',
      'Ambulancias, policía y bomberos, con las señales de advertencia reglamentarias activadas.',
    ],
    correctIndices: [2],
  ),
  Question(
    text: '¿Que indica la luz roja del semáforo?',
    options: [
      'Que debe detenerse.',
      'Que puede avanzar sino circula otro vehículo transversalmente.',
      'Que puede avanzar sino cruzan peatones.',
    ],
    correctIndices: [0],
  ),
  Question(
    text: '¿Cuál es la velocidad máxima permitida en calles urbanas?:',
    options: ['40 km.', '60 km.', '80 km.'],
    correctIndices: [0],
  ),
  Question(
    text: '¿Cuál es la velocidad máxima permitida en avenidas urbanas?:',
    options: ['60 km.', '80 km.', '90 km.'],
    correctIndices: [0],
  ),
  Question(
    text:
        'Las órdenes de los agentes de tránsito pueden modificar y aún contradecir la señalización, en casos de conflicto, conveniencia o emergencia',
    options: ['Verdadero.', 'Falso.'],
    correctIndices: [0],
  ),
  Question(
    text:
        'Al llegar a una intersección entre una calle y una avenida ¿ a quién se le debe ceder el paso?',
    options: [
      'A los peatones.',
      'A quien circule por la izquierda.',
      'A quien circule por la derecha.',
      'A quien circula a mayor velocidad.',
    ],
    correctIndices: [0],
  ),
  Question(
    text: '¿Cómo se debe estacionar en una calle de mano única?:',
    options: [
      'En el mismo sentido que la circulación del tránsito.',
      'No interesa el sentido si guarda las distancias.',
      'No interesa el sentido si lo hace sobre la derecha y guardando las distancias reglamentarias por Ley.',
    ],
    correctIndices: [0],
  ),
  Question(
    text: 'Indique el orden correcto de prioridad normativa',
    options: [
      'Ley vigente, Señales de tránsito, ordenanza.',
      'Agente de tránsito, señales de tránsito, ley vigente.',
      'Conductor, Señales de tránsito, Ordenanza.',
    ],
    correctIndices: [1],
  ),
  Question(
    text: 'La señal de prevención de color anaranjado indica:',
    options: [
      'Un peligro en una ruta con características normales.',
      'Un peligro: ruta en obra.',
    ],
    correctIndices: [1],
  ),
  Question(
    text:
        'Una señal reglamentaria de prohibición o restricción. ¿Desde dónde tiene vigencia?',
    options: [
      'Desde donde el usuario la vea.',
      'Desde el lugar donde está emplazada.',
    ],
    correctIndices: [1],
  ),
  Question(
    text: 'Que indica el señalamiento vertical de color azul',
    options: ['Restricción', 'Información', 'Prevención'],
    correctIndices: [1],
  ),
  Question(
    text: 'Que indica el señalamiento vertical con una orla roja',
    options: ['Restricción', 'Información', 'Prevención'],
    correctIndices: [0],
  ),
  Question(
    text: 'Que indica el señalamiento vertical de color amarillo',
    options: ['Restricción', 'Información', 'Prevención'],
    correctIndices: [2],
  ),
  Question(
    text:
        '¿Qué está indicando el agente de tránsito al realizar esta señal a un conductor?',
    options: [
      'Que circule con precaución.',
      'Que detenga el vehículo.',
      'Que continúe avanzando.',
    ],
    correctIndices: [1],
    imagePath: 'assets/icon/categoria-a/pregunta-33.png',
  ),
  Question(
    text:
        'Los Agentes de Tránsito pueden proceder a la detención de un vehículo únicamente con la presencia de personal policial.',
    options: ['Verdadero.', 'Falso.'],
    correctIndices: [1],
  ),
  Question(
    text: '¿Qué significa esta demarcación amarilla en la calzada?',
    options: [
      'Es una señalización que se utiliza únicamente para dividir los carriles de la vía.',
      'Indica, para ambos sentidos de circulación, que no debe ser traspasada ni se puede circular sobre ella.',
      'Significa que sólo pueden circular vehículos particulares.',
    ],
    correctIndices: [1],
    imagePath: 'assets/icon/categoria-a/pregunta-35.png',
  ),
  Question(
    text:
        'En la siguiente imagen, ¿qué indican las líneas centrales de la calzada señaladas?',
    options: [
      'Que se pueden traspasar.',
      'Que está prohibido traspasarlas.',
      'Que es una zona de máximo peligro.',
    ],
    correctIndices: [0],
    imagePath: 'assets/icon/categoria-a/pregunta-36.png',
  ),
  Question(
    text: '¿Cuál de estas señales comunica “Prevención”?',
    options: ['La señal A.', 'La señal B.', 'La señal C.'],
    correctIndices: [1],
    imagePath: 'assets/icon/categoria-a/pregunta-38.png',
  ),
  Question(
    text: '¿Cuál de estas señales es una señal reglamentaria?',
    options: ['La señal A.', 'La señal B.', 'La señal C.'],
    correctIndices: [0],
    imagePath: 'assets/icon/categoria-a/pregunta-39.png',
  ),
  Question(
    text:
        '¿Cuál de las siguientes imágenes, por forma y color, corresponde a la señal indicativa de estar próximo a una zona afectada por obras?',
    options: ['La señal A.', 'La señal B.', 'La señal C.'],
    correctIndices: [1],
    imagePath: 'assets/icon/categoria-a/pregunta-40.png',
  ),
  Question(
    text: 'Indique cual es la correcta:',
    options: ['Puesto sanitario', 'Emergencias', 'Policía'],
    correctIndices: [0],
    imagePath: 'assets/icon/categoria-a/pregunta-41.png',
  ),
  Question(
    text: 'La siguiente señal indica:',
    options: [
      'Permitido girar derecha',
      'Dirección permitida derecha',
      'Circulación obligatoria',
    ],
    correctIndices: [0],
    imagePath: 'assets/icon/categoria-a/pregunta-42.png',
  ),
  Question(
    text: 'La siguiente señal indica:',
    options: [
      'Puente móvil',
      'Inicio de calzada dividida',
      'Túnel',
    ],
    correctIndices: [1],
    imagePath: 'assets/icon/categoria-a/pregunta-43.png',
  ),
];
