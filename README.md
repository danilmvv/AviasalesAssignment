# Тестовое Aviasales

## Описание

Лучшее тестовое для поиска дешевых ~~разработчиков~~ авиабилетов

## 📋 Функциональные требования

### Что было реализовано
1. При запуске приложения, получаем массив рейсов от сервера
2. Рейсы сортируются и отображаются от самого дешевого к самому дорогому и отображаются на экране
3. У самого дешёвого есть бейдж **Самый дешёвый**
4. На карточке отображается информация о том, что для рейса осталось меньше 10 билетов
5. При тапе на рейс открывается детальный экран
6. На детальном экране по нажатию кнопки **Купить** показывается алерт **Куплен билет за X ₽,** где X — это цена выбранного билета

## 🛠 Технические требования

### Что было реализовано
1. Проект iOS 16+
2. Пользовательский интерфейс на SwiftUI
3. Реализован Network слой для работы с сетевыми запросами. Запросы выполняются с помощью async/await.
4. Модели ответов парсятся с помощью протокола Codable

## ⚡️ Ключевые решения
- Использовалась **MVVM архитектура**
- Был написан удобный **сетевой слой** с использованием **Swift Concurrency** (async/await) для эффективной обработки всех API-запросов
- Реализован **кастомный лоадер**
- При ошибке запроса, отображается текст "Что-то пошло не так" и кнопка **Повторить**, которая заново отправляет запрос
- **Цвета, шрифты и иконки** взяты из макета и используются в приложении в виде enum'ов
- Поддержка **темной темы**
- Используется библиотека `swift-dependencies` от point-free для DI сетевого слоя
