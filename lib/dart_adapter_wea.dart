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

import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class WeatherService {
  Future<WeatherData> getWeather(String location);
}

// Weather data class
class WeatherData {
  final DateTime date;
  final String location;
  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;

  WeatherData({
    required this.date,
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });
}

// OpenWeatherMap API
// Клас OpenWeatherMapApi - це зовнішній API, який повертає погодні дані у
// вигляді JSON-відповіді.
class OpenWeatherMapApi {
  // Зробити виклик API до OpenWeatherMap
  // і повернути відповідь JSON

  // Ось приклад того, як можна зробити виклик API до OpenWeatherMap і повернути
  // відповідь JSON за допомогою http-пакету в Dart:

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final lat = 46.48572;
    final lon = 30.74383;
    final appId =
        'd7f3fb73c94b0165061b6b96fc397852'; // Replace with your app ID
    final url =
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&units=metric&exclude=minutely,hourly,daily,alerts&appid=$appId';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}

// OpenWeatherMap adapter
// Клас OpenWeatherMapAdapter реалізує інтерфейс WeatherService і адаптує клас
// OpenWeatherMapApi до цього інтерфейсу. Він отримує екземпляр
// OpenWeatherMapApi в конструкторі і використовує його для виклику API в методі
// getWeather. Відповідь у форматі JSON потім зіставляється з об'єктом
// WeatherData і повертається.

class OpenWeatherMapAdapter implements WeatherService {
  final OpenWeatherMapApi _api;

  OpenWeatherMapAdapter(this._api);

  @override
  Future<WeatherData> getWeather(String location) async {
    final json = await _api.fetchWeather(location);
    final temperature = json['current']['temp'];
    final humidity = json['current']['humidity'];
    final pressure = json['current']['pressure'];
    final date =
        DateTime.fromMillisecondsSinceEpoch((json['current']['dt'] * 1000));
    final windSpeed = json['current']['wind_speed'];
    return WeatherData(
      location: location,
      temperature: temperature,
      humidity: humidity,
      pressure: pressure,
      date: date,
      windSpeed: windSpeed,
    );
  }
}

// Client code
// Клієнтський код створює екземпляр OpenWeatherMapApi і передає його екземпляру
// OpenWeatherMapAdapter. Потім він викликає getWeather з параметром
// location і роздруковує погодні дані.
void main() async {
  final api = OpenWeatherMapApi();
  final service = OpenWeatherMapAdapter(api);
  final weatherData = await service.getWeather('Odessa');
  print('Location: ${weatherData.location}');
  print('Temperature C: ${weatherData.temperature}');
  print('Humidity %: ${weatherData.humidity}');
  print('Date: ${weatherData.date}');
  print('Pressure hPa: ${weatherData.pressure}');
  print('Wind speed m/s: ${weatherData.windSpeed}');
}
