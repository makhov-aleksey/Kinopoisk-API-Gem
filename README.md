# КиноПоиск API / Gem для Rails

Гем основан на API от Andrzej Wielski: http://docs.kinopoiskapi.apiary.io/. Спасибо автору за такую великолепную реализацию.

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
kinopoisk = KinopoiskAPI::Film.new(733493)
```
```ruby
#   Вся информация о фильме
kinopoisk.all
```
```ruby
#   Название фильма на русском
kinopoisk.title
```
```ruby
#   Оригинальное название фильма
kinopoisk.original_title
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

