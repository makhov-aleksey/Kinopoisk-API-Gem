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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

