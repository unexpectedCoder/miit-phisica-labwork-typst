# Инструкция по публикации пакета в Typst Universe

## Предварительные требования

- Аккаунт на [Typst Universe](https://typst.app/universe)
- Git установлен на компьютере
- Доступ к репозиторию на GitHub

## Шаги публикации

### 1. Подготовка пакета

Убедитесь, что в корневой директории проекта есть файл `typst.toml` с правильной конфигурацией:

```toml
[package]
name = "miit-physica-labs"
version = "1.0.0"
entrypoint = "lib.typ"
authors = ["unexpectedCoder"]
license = "MIT"
description = "Шаблон отчёта по лабораторной работе кафедры «Физика» РУТ (МИИТ). Template for physics lab reports at MIIT."
repository = "https://github.com/unexpectedCoder/miit-phisica-labwork-typst"
keywords = ["template", "report", "physics", "lab", "russian", "miit"]
categories = ["template"]
```

### 2. Проверка структуры проекта

Убедитесь, что проект содержит:

```
miit-physica-labs/
├── lib.typ              ✓ Точка входа пакета
├── labreport.typ        ✓ Основной модуль
├── lab.typ              ✓ Пример использования
├── typst.toml           ✓ Конфигурация пакета
├── README.md            ✓ Инструкция по использованию
├── PACKAGE.md           ✓ Документация пакета
├── лого.png             ✓ Логотип
├── pics/                ✓ Папка с изображениями
└── .gitignore           ✓ Исключения для Git
```

### 3. Проверка файла `lib.typ`

Убедитесь, что `lib.typ` правильно экспортирует функции:

```typst
#import "labreport.typ": labreport, noindent, appendixes

pub use labreport: labreport, noindent, appendixes
```

### 4. Коммит и push в GitHub

```bash
git add .
git commit -m "Prepare package for Typst Universe publication"
git push origin main
```

### 5. Создание релиза на GitHub

1. Перейдите на страницу репозитория: https://github.com/unexpectedCoder/miit-phisica-labwork-typst
2. Нажмите на **Releases** в правой панели
3. Нажмите **Create a new release**
4. Заполните поля:
   - **Tag version**: `v1.0.0`
   - **Release title**: `Version 1.0.0`
   - **Description**: Описание изменений (опционально)
5. Нажмите **Publish release**

### 6. Публикация в Typst Universe

1. Перейдите на https://typst.app/universe
2. Нажмите **Publish a package**
3. Авторизуйтесь с помощью GitHub
4. Выберите репозиторий `miit-phisica-labwork-typst`
5. Заполните информацию о пакете:
   - **Package name**: `miit-physica-labs`
   - **Version**: `1.0.0`
   - **Description**: Скопируйте из `typst.toml`
   - **License**: MIT
   - **Repository**: GitHub URL
6. Нажмите **Publish**

## Использование опубликованного пакета

После публикации пакет можно использовать так:

```typst
#import "@preview/miit-physica-labs:1.0" as miit: labreport, noindent, appendixes
#import "@preview/physica:0.9.8": *

#set document(title: "Название работы")

#show: miit.labreport.with(
  designation: "Л-1",
  authors: ((name: "Иван Петров"),),
  affilation: (group: "РТ-101", subgroup: "1", crew: "1"),
  teacher: "Проф. И.И. Иванов",
  lector: "Доц. П.П. Петров",
  abstract: [Краткое описание...]
)

// Текст отчёта...
```

## Обновление пакета

Для выпуска новой версии:

1. Обновите версию в `typst.toml`:
   ```toml
   version = "1.1.0"
   ```

2. Сделайте коммит:
   ```bash
   git add typst.toml
   git commit -m "Bump version to 1.1.0"
   git push origin main
   ```

3. Создайте новый релиз на GitHub с тегом `v1.1.0`

4. Typst Universe автоматически обновит пакет в течение нескольких минут

## Проверка перед публикацией

Убедитесь, что:

- [ ] Файл `typst.toml` содержит корректные метаданные
- [ ] `lib.typ` правильно экспортирует функции
- [ ] `README.md` содержит инструкции по использованию
- [ ] `PACKAGE.md` содержит полную документацию
- [ ] Все изображения находятся в папке `pics/`
- [ ] Логотип `лого.png` присутствует
- [ ] Нет синтаксических ошибок в `.typ` файлах
- [ ] Репозиторий на GitHub публичный
- [ ] Лицензия указана в `typst.toml` (MIT)

## Полезные ссылки

- [Typst Universe](https://typst.app/universe)
- [Документация по публикации пакетов](https://typst.app/docs/reference/packages/)
- [GitHub репозиторий](https://github.com/unexpectedCoder/miit-phisica-labwork-typst)

## Поддержка

Если у вас возникли проблемы при публикации, обратитесь к:
- [Документации Typst](https://typst.app/docs/)
- [Форуму сообщества Typst](https://github.com/typst/typst/discussions)
- [Issues репозитория](https://github.com/unexpectedCoder/miit-phisica-labwork-typst/issues)
