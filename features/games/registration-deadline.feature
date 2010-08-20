#language:ru
Функционал: Предварительная регистрация на игру
  Как автор я хочу устанавливать крайний срок регистрации команд на игру

  Предыстория:
    Допустим сейчас "2010-05-25 00:00"
    И я залогинен как Author
    И захожу в личный кабинет

  Сценарий: Автор создает игру и указывает крайний срок регистрации
    Если я иду по ссылке "Создать игру"
    То должен увидеть "Крайний срок регистрации"
    Если я ввожу "Game1" в поле "Название"
    И ввожу "Desc" в поле "Описание"
    И ввожу "2010-05-30 00:00" в поле "Начало игры"
    И ввожу "2010-05-27 00:00" в поле "Крайний срок регистрации"
    И ввожу "6" в поле "Максимальное количество команд"
    И нажимаю "Создать игру"
    То должен увидеть "Game1"
    И должен увидеть "Крайний срок регистрации"
    И должен увидеть "2010-05-27 00:00"

  Сценарий: Автор создает игру и вводит крайний срок регистрации меньше текущей даты
    Если я иду по ссылке "Создать игру"
    И я ввожу "Game1" в поле "Название"
    И ввожу "Desc" в поле "Описание"
    И ввожу "2010-05-30 00:00" в поле "Начало игры"
    И ввожу "2010-05-24 00:00" в поле "Крайний срок регистрации"
    И ввожу "6" в поле "Максимальное количество команд"
    И нажимаю "Создать игру"
    То должен увидеть "Вы указали крайний срок регистрации из прошлого, так нельзя"

  Сценарий: Автор создает игру и вводит крайний срок регистрации больше даты начала игры
    Если я иду по ссылке "Создать игру"
    И я ввожу "Game1" в поле "Название"
    И ввожу "Desc" в поле "Описание"
    И ввожу "2010-05-30 00:00" в поле "Начало игры"
    И ввожу "2010-06-02 00:00" в поле "Крайний срок регистрации"
    И нажимаю "Создать игру"
    То должен увидеть "Вы указали крайний срок регистрации больше даты начала игры, так нельзя"

  #Сценарий: Календарь заполняет указанным значением крайний срок регистрации
  #	Если я иду по ссылке "Создать игру"
  #  И ввожу "2010-05-30 00:00" в поле "Начало игры"
  #	То должен увидеть "Крайний срок регистрации: 2010-05-30 00:00"
  # Следующий сценарий сработает после выполнения тикета #37
  @dev
  Сценарий: Пользователь видит крайний срок регистрации на игру
    Допустим сейчас "2010-05-27 00:00"
    И Автор создал игру "Game1" с началом в "2010-05-30 00:00" и с крайним сроком регистрации в "2010-05-28 00:00"
    И зарегистрирована команда "Team1" под руководством Cap1
    Если я логинюсь как Cap1
    И захожу в профиль игры "Game1"
    И должен увидеть "Крайний срок регистрации"
    И должен увидеть "2010-05-28 00:00"

  Сценарий: Пользователь подает запрос на регистрацию в игре
    Допустим сейчас "2010-05-27 00:00"
    И я не залогинен
    И Автор создал игру "Game1" с началом в "2010-05-30 00:00" и с крайним сроком регистрации в "2010-05-28 00:00"
    И зарегистрирована команда "Team1" под руководством Cap1
    Если я логинюсь как Cap1
    И захожу в личный кабинет
    И должен увидеть "Game1"
    И должен увидеть "Подать заявку на регистрацию"
    Если я иду по ссылке "Подать заявку на регистрацию"
    То должен увидеть "Game1"
    И должен увидеть "Заявка подана"

  Сценарий: Пользователь пытается подать заявку на участи в игре после даты, указанной в крайнем сроке регистрации
    Допустим сейчас "2010-07-03 00:00"
    И я не залогинен
    И Автор создал игру "Game1" с началом в "2010-07-09 00:00" и с крайним сроком регистрации в "2010-07-04 00:00"
    И сейчас "2010-07-05 00:00"
    И зарегистрирована команда "Team1" под руководством Cap1
    Если я логинюсь как Cap1
    И захожу в личный кабинет
    То должен увидеть "Game1"
    И должен увидеть "Вы не можете зарегистрироваться"