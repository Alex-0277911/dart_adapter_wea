// Ось приклад того, як можна використати шаблон адаптера в Dart для додатку погоди:

// У цьому прикладі інтерфейс WeatherService визначає метод getWeather,
// який отримує параметр location і повертає об'єкт WeatherData.
// Клас OpenWeatherMapApi - це зовнішній API, який повертає погодні дані у
// вигляді JSON-відповіді.

// Клас OpenWeatherMapAdapter реалізує інтерфейс WeatherService і адаптує клас
// OpenWeatherMapApi до цього інтерфейсу. Він отримує екземпляр
// OpenWeatherMapApi в конструкторі і використовує його для виклику API в методі
// getWeather. Відповідь у форматі JSON потім зіставляється з об'єктом
// WeatherData і повертається.

// Клієнтський код створює екземпляр OpenWeatherMapApi і передає його екземпляру
// OpenWeatherMapAdapter. Потім він викликає getWeather з параметром
// location і роздруковує погодні дані.

// Weather service interface
// У цьому прикладі інтерфейс WeatherService визначає метод getWeather,
// який отримує параметр location і повертає об'єкт WeatherData.