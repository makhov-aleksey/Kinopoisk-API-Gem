# КиноПоиск API / Gem для Rails

Гем основан на API от Andrzej Wielski: http://docs.kinopoiskapi.apiary.io/. Спасибо автору за такую великолепную реализацию.

Этот gem создан для упрощения работы с КиноПоиск API в проектах Ruby on Rails.

## Установка

Добавьте эту строку в Gemfile вашего приложения:

```ruby
gem 'KinopoiskAPI' , github: 'afuno/Kinopoisk-API', branch: 'master'
```

Затем выполните:

    $ bundle


## Использование

### Фильм

```ruby
film = KinopoiskAPI::Film.new(733493)
```
```ruby
#   Вся информация о фильме
film.all
```
```ruby
#   Название фильма на русском
film.title
```
```ruby
#   Оригинальное название фильма
film.original_title
```

Доступны следующие методы:

* **url** - URL адрес страницы на КиноПоиск
* **title** - Название на русском
* **original_title** - Название на английском (оригинальное название)
* **slogan** - Слоган
* **description** - Описание
* **poster** - Полный адрес на постер (в формате JPG)
* **year** - Год выхода (у сериалов год начала и окончания)
* **kinopoisk** - Массив следующих данных (КиноПоиск):
    * **rating** - Рейтинг
    * **quantity** - Количество оценивших
    * **good_reviews_in_percentage** - Количество положительных рецензий в процентах
    * **number_of_good_reviews** - Количество положительных рецензий
    * **waiting_in_percentage** - Количество ожидающих в процентах
    * **number_of_waiting** - Количество ожидающих
* **imdb** - Массив следующих данных (IMDb)
    * **rating** - Рейтинг
    * **quantity** - Количество оценивших
* **number_of_reviews** - Количество рецензий
* **duration** - Продолжительность фильма или эпизода у сериала
* **countries** - Страна или список стран
* **genres** - Список жанров
* **video** - Полный адрес на трейлер
* **minimal_age** - Минимальный рекомендуемый возраст

### Режисеры, актеры, операторы и т. д.

```ruby
staff = KinopoiskAPI::Staff.new(733493)
```
```ruby
#   Все имена всех профессий
staff.all
```
```ruby
#   Все имена одной профессии
staff.profession('writer')
```

Доступны следующие методы:

* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb
* **aaaa** - bbbb

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

