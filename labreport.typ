// Величина абзацного отступа
#let indent_value = 2em
// Убрать абзацный отступ по требованию
#let noindent = h(-indent_value)
// Межстрочный интервал
#let spacing = 1.15em


#let labreport(
  designation: [],
  authors: (),
  affilation: (),
  teacher: (),
  lector: (),
  abstract: [],
  doc
) = {
  set text(
    font: "STIX Two Text",
    lang: "ru",
    size: 12pt,
  )

  set page(
    paper: "a4",
    margin: (
      left: 2.5cm,
      right: 1cm,
      rest: 1.5cm
    ),
    footer: context {
      let page_num = counter(page).get().first()
      if page_num == 1 {
        // Футер титульной страницы
        set text(size: 11pt)
        align(center)[Москва, #datetime.today().year()]
      } else {
        // Номер страницы для всех остальных листов
        align(center)[#counter(page).display("1")]
      }
    }
  )

  place(
    top + center,
    float: true,
    scope: "parent",
    {
      grid(
        columns: (2fr, 3fr),
        align: (left, center),
        [#image("лого.png", width: 70%)],
        text(size: 10pt)[
          Федеральное государственное автономное \ образовательное учреждение высшего образования \ «Российский университет транспорта» (РУТ (МИИТ)) \
          Кафедра «Физика» им. П.Н. Лебедева \
          Академия базовой подготовки
        ],
      )
      
      v(1cm)
      
      text(size: 16pt, tracking: 2pt)[
        Работа #upper(designation)
      ]
      v(-0.5em)
      
      upper(title())
      v(1cm)

      par(justify: false)[
        Выполнили студенты группы~#upper(affilation.group), подгруппа~#affilation.subgroup, бригада~#affilation.crew
      ]
      v(1em)
      
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 0.8em,
        ..authors.map(author => [
          #author.name
        ]),
      )

      v(1cm)
      grid(
        columns: (1fr, 1fr),
        row-gutter: 0.8em,
        [Преподаватель:\ #teacher], [Лектор:\ #lector],
      )

      v(2em)
      grid(
        columns: (1fr, 1fr, 5fr),
        rows: 4,
        row-gutter: 2em,
        column-gutter: 0.5em,
        align: (right, left, left),
        [Допуск:], [\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_], [],
        [Измерение:], [\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_], [],
        [Защита:], [\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_], [],
        [Оценка:], [\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_], [],
      )

      v(2cm)
      par(justify: false, leading: 0.8em)[
        *Аннотация* \
        #text(size: 11pt)[#abstract]
      ]
      v(1.5em)
    }
  )

  
  pagebreak()


  // Списки
  // - нумерованные
  set enum(
    numbering: "1.",
    indent: indent_value,
    body-indent: 1em
  )
  // - маркированные
  set list(
    indent: indent_value,
    body-indent: 1em,
  )

  // Настройка абзацев
  set par(
    first-line-indent: (amount: indent_value, all: true),
    justify: true,
    leading: spacing,
    spacing: spacing,
  )

  // Заголовки
  show heading: set align(center)
  show heading: set par(justify: false)
  show heading: set block(above: 1.5em, below: 1.15em)
  
  // Формат ссылок на формулы, рисунки, таблицы
  show ref: it => {
    let el = it.element
    if el == none { return it }
    
    if el.func() == figure {
      let loc = el.location()
      // Выбираем счетчик в зависимости от типа фигуры
      let kind = el.kind
      let nums = counter(figure.where(kind: kind)).at(loc)
      
      return link(loc, numbering(el.numbering, ..nums))
    }
    
    // Ссылки на уравнения
    if el.func() == math.equation {
      let loc = el.location()
      return link(loc, numbering(el.numbering, ..counter(math.equation).at(loc)))
    }
    
    it
  }

  // Рисунки (figure)
  show figure: set block(
    above: spacing + 0.5em, 
    below: spacing + 0.5em
  )
  // Настройка подписи для таблиц
  show figure.where(kind: table): set figure.caption(position: top)
  // Единый стиль оформления подписи рисунков и таблиц
  show figure.caption: it => {
    if it.kind == table {
      // Стиль для ТАБЛИЦ: Номер справа курсивом, текст по центру
      grid(
        columns: (1fr),
        row-gutter: 0.5em,
        align(right)[_#it.supplement #context it.counter.display(it.numbering)_],
        align(center)[#it.body]
      )
    } else {
      // Стиль для РИСУНКОВ (по умолчанию): снизу по центру
      set align(center)
      block[
        *#it.supplement #context it.counter.display(it.numbering)*. #it.body
      ]
    }
  }

  // Математика
  // Шрифт
  show math.equation: set text(font: "STIX Two Math")
  // Замена десятичного разделителя: "." → ","
  show math.equation: it => {
    show regex("\d+\.\d+"): it => {
      show ".": {","+h(0pt)}
      it
    }
    it
  }
  // Прямое начертание для греческих символов
  show math.equation: it => {
    show regex("[\u{0370}-\u{03FF}]"): math.upright
    it
  }

  // Цвет гиперссылок
  // show link: set text(fill: black)
  
  doc
}
