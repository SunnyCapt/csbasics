## Lab5

#### тут в программе есть косяки

### [finished work](../static/lab5.pdf)
### [trace](../static/lab5-trace.pdf)

## Answers

1. Синхронный и асинхронный режимы передачи данных.
    * синхронная передача - каждый передаваемый бит сопровождается импульсом синхронизации, первыми поступают символы синронизации
    * асинхронная передача - отсутствует общий генератор синроимпульсов. В этом режиме нужно чтобы передатчик и приемник были согласованы по формату и скорости передачи. Для этого в них обоих есть генераторы синхроимпульсов с одинаковой частотой.
    
2. Программно-управляемый и управляемый прерываниями ввод-вывод, прямой доступ к памяти. Преимущества и недостатки. 
    * Программно-управляемый ввод-вывод - передача осуществляется заранее описанной программой ЭВМ через внутренние регистры
        * Преимущества: проста в реализации (по сравнению с программно-управляемой)
        * Недостатки: передача данных осуществляется малыми порциями, в некоторых случаях тратится много времени на ожидание.
        * синхронный прост во всех отношениях, но не пригоден когда мы не знаем когда именно можно передать/принять данные и когда ву медленный относительно БЭВМ
        * асинхронный - круто, нам не надо знать конкретное время передачи, но уходит время на ожидание готовности, т.к. готовность ВУ проверяется программно
    * Управляемый прерываниями ввод-вывод - передача данных осуществляется аппаратными средставми
        * Преимущества: экономия времени в силу использования аппаратных средств
        * Недостатки: сложнее чем синхронный/асинхронный способ
    * Прямой доступ к памяти
        * Преимущества: скорость, можно передавать сразу большие объемы данных
        * Недостатки: сложно в реализации
        
3. Способы и формат представления символьных и строковых данных в БЭВМ. Кодировки ASCII, КОИ-8, Windows-1251, ISO-8859-5, UTF-8, UTF-16. 
    * https://sun9-9.userapi.com/c858432/v858432252/2553/2J6sxVqT37c.jpg
    * https://habr.com/ru/post/158639/
    * https://ru.wikipedia.org/wiki/ASCII 
    * https://ru.wikipedia.org/wiki/КОИ-8 
    * https://ru.wikipedia.org/wiki/Windows-1251 
    * https://ru.wikipedia.org/wiki/ISO_8859-5
    * UTF-32 – это кодировка, которая переводит все символы в наборы из 32 бит. Это простой алгоритм, но изводящий много места впустую. UTF-16 и UTF-8 являются кодировками с переменной длиной кодирования. Если символ может быть закодирован одним байтом(потому что номер пункта символа очень маленький), UTF-8 закодирует его одним байтом. Если нужно 2 байта, то используется 2 байта. Кодировка сообщает старшими битами, сколькими битами кодируется текущий символ. Такой способ экономит место, но так же и тратит его в случае, если эти сигнальные биты часто используются. UTF-16 является компромиссом: все символы как минимум двухбайтные, но их размер может увеличиваться до 4 байт, если нужно.
    Проанализировав биты первого байта. В случае с UTF-8 длина символа определяется так:
    0xxx xxxx — один
    110x xxxx — два
    1110 xxxx — три
    Все непервые байты символов при этом должны будут иметь вид 10xx xxxx, поэтому разрыв потока грозит потерей максимум одного символа.
    UTF-16 эксплуатирует тот факт, что с U+D800 по U+DFFF в Юникоде валидных символов быть не может, и использует этот диапазон для четырёхбайтовго кодирования всех дополнительных планов с U+10000 по U+10FFFF. Стало быть, если попадается 1101 01xx — 1101 xxxx, то перед нами четырёхбайтовый символ.
    
4. Порядок байтов в памяти от младшего к старшему (little-endian) и от старшего к младшему (big-endian). 
    * https://sun9-53.userapi.com/c858432/v858432252/254a/SBA1nQcm0sU.jpg
    * https://ru.wikipedia.org/wiki/Порядок_байтов
    
5. Система команд ввода-вывода БЭВМ. Команды IN, OUT, CLF, TSF - название, назначение и тип команды. Количество и название машинных циклов, потактовое выполнение команды, с перечислением всех шин, участвующих в обмене. 
    * Тип команд - команды ввода-вывода
    * IN - ввод
    * Назначение: записывает в младшие 8 разрядов аккумулятора значения из РДВУ
        - выборка команды
            + СК => БР
            + БР => РА
            + ОП(РА) => РД; СК + 1 => БР
            + БР => СК
            + РД => БР
            + БР => РК
            + 4 проверки на код операции, после GOTO на В/В
        - исполнение
            + По шинам приказа и адреса адрес и приказ поступает на дешифраторы всех ВУ, и по шине данных передаётся значение хранящееся в РД указанного ВУ в младшие 8 бит аккумулятора
    * OUT - вывод
    * Назначение: записывает в РДВУ значения из младших 8 разрядов аккумулятора
        - выборка команды
            + СК => БР
            + БР => РА
            + ОП(РА) => РД; СК + 1 => БР
            + БР => СК
            + РД => БР
            + БР => РК
            + 4 проверки на код операции, после GOTO на В/В
        - исполнение
            + По шинам приказа и адреса адрес и приказ поступает на дешифраторы всех ВУ, устанавливается соединение с указанным ВУ через шину данных. В РД указанного ВУ записывается значения младших 8 бит аккумулятора.
    * CLF - очистка флага готовности
    * Очищает флаг готовности ВУ
        - выборка команды
            + СК => БР
            + БР => РА
            + ОП(РА) => РД; СК + 1 => БР
            + БР => СК
            + РД => БР
            + БР => РК
            + 4 проверки на код операции, после GOTO на В/В
        - исполнение
            + По шинам приказа и адреса адрес и приказ поступает на дешифраторы всех ВУ, флаг указанного ВУ сбрасывается и снимается сигнал на прерывание(возникший при нажатии готовности на ВУ)
    * TSF - опрос флага готовности
    * Опрашивает флаг готовности ВУ, копирует его значение в флаг состояния ВУ (в устройстве управления)
        - выборка команды
            + СК => БР
            + БР => РА
            + ОП(РА) => РД; СК + 1 => БР
            + БР => СК
            + РД => БР
            + БР => РК
            + 4 проверки на код операции, после GOTO на В/В
        - исполнение
            + по шинам адреса и приказа адрес и приказ команды поступают на дешифраторы всех ВУ
            + по линии "Состояние флага ВУ" указанное ВУ передает в УУ состояние флага
  
6. Какие режимы передачи данных и управления вводом-выводом реализуемы в БЭВМ? Почему не возможно реализовать другие? 
    * Режимы передачи данных:
        1. Синхронный - реализована
        2. Асинхронный - реализована
    * Режимы управления вводом-выводом:
        1. Программно-вправляемый - реализован
        2. ПДП - не реализован, т.к. для его использования нужно изменить системный интерфейс БЭВМ
    
7. Может ли ВУ определить в каком режиме с ним работают? 
    * Может, когда дешифратор приказов понимает это.
    
8. Назначение флага готовности ВУ, регистра данных ВУ (РДВУ), флага состояния ВУ (ФГВУ)? 
    * Флаг готовности ВУ - регистр внешнего устройства, сообщающий о готовности
    * Флаг состояния ВУ  - в него копируется значение из флага готовности ВУ, при выполнении TSF
    * Регистр данных ВУ - буфер ВУ

9. Какие элементы БЭВМ участвуют в обмене с ВУ? Укажите направление передачи данных между элементами при операциях ввода и вывода. 
    * см. вопрос #5
    
10. Опрашивает ли ВУ состояние флага готовности ВУ, если да то при каких условиях? 
    * да, логика управления опрашивает готовность после того как переданы все данные    