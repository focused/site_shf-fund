require 'ffaker'

# ------------------------------------------------------------------------------
# App

p "Seeding Document..."

create_by = AppData::Seed[Document]

create_by[name: "Главная"].(
  path: "/",
  handler: "Catalog::ProductCategoryDocument"
)
create_by[name: "Страница продукта"].(
  path: "/",
  handler: "Catalog::ProductDocument"
)
create_by[name: "О компании"].(
  path: "/about",
  content: <<-CONTENT
<p><img align="right" src="/images/chair.jpg" /></p>
<p>Kilta это классическое финское кресло. Узнаваемый дизайн стула, эргономика и
долговечность гарантирует его дальнейший успех. Kilta идеально подходит как для
конференц-залов, так и напряженной офисной работы за рабочим столом. Его мягкие,
округлые формы придает уют любому помещению. Kilta стул с колесиками было
запущен в производство недавно, имеет возможность регулировки по высоте и
механизмом качания. Различные вариации обивки обеспечивают универсальные
возможности для создания интересного небанального интерьера. Стул серии Kilta
также включает и Мини Kilta - кресло с диском в качестве опоры или базы из
четырх ножек. Когда-то кресло Kilta былл первым пластиковым стулом в Финляндии,
в силу его новаторской технологии вошел в коллекцию Martela еще в 1955 году.
</p>
<p>Kilta это классическое финское кресло. Узнаваемый дизайн стула, эргономика и
долговечность гарантирует его дальнейший успех. Kilta идеально подходит как для
конференц-залов, так и напряженной офисной работы за рабочим столом. Его мягкие,
округлые формы придает уют любому помещению. Kilta стул с колесиками было
запущен в производство недавно, имеет возможность регулировки по высоте и
механизмом качания. Различные вариации обивки обеспечивают универсальные
возможности для создания интересного небанального интерьера.</p>
  CONTENT
)

documents = {
  payment_and_delivery: "Оплата и доставка",
  contacts: "Контакты",
  terms_and_conditions: "Пользовательское соглашение",
  privacy_policy: "Соглашение о конфиденциальности"
}
documents.each do |key, value|
  create_by[name: value].(
    path: "/#{key}",
    content: "<p></p>"
  )
end


# ------------------------------------------------------------------------------
# Catalog

p "Seeding ProductCategory, Product, ProductPhoto..."

categories = {
  desktops: ["Рабочие столы", {
    direct: "Прямые",
    angular: "Угловые",
    benches: "Бенчи",
    covering_panels: "Панели, закрывающие ноги",
    board_partitions: "Настольные перегородки",
    interior_partitions: "Напольные перегородки",
    accessories: "Аксессуары"
  }],
  desk_chairs: ["Рабочие кресла", {
    back_mesh: "Спинка-сетка",
    standard_backrest_cloth: "Стандартная спинка, ткань"
  }],
  chairs: ["Стулья", {
    wooden: "Деревянные",
    plastic: "Пластиковые",
    in_upholstery: "В обивке",
    on_wheels: "На колесиках",
    on_runners: "На полозьях",
    legged: "На ножках"
  }],
  cupboards_and_cabinets: ["Шкафы и тумбы", {
    high: "Высокие",
    average: "Средние",
    low: "Низкие"
  }],
  soft_group: ["Мягкие группы", {
    modular_sofa: "Диван модульный",
    sofa_straight: "Диван прямой",
    sofa_corner: "Диван угловой",
    sofa_acoustic: "Диван акустический",
    chair: "Кресло",
    pridivanny_table: "Придиванный столик"
  }],
  acoustics: ["Акустические решения", {
    panel: "Панели",
    septa: "Перегородки",
    wallpaper: "Обои",
    sofas: "Диваны"
  }],
  other: ["Прочее", {
    call_box: "Телефонная будка",
    meeting_room: "Переговорная комната",
    marker_and_projector_boards: "Доски для маркера, проектора",
    lamp: "Светильник",
    partition: "Перегородка"
  }]
}

Product.destroy_all if Rails.env.development?

# main categories
categories.each_with_index do |(parent_key, parent_data), parent_index|
  parent_category =
    ProductCategory.in_category(nil)
      .where(name: parent_data.first, path: "/#{parent_key}")
      .first_or_create!

  # secondary categories
  parent_data.second.each_with_index do |(key, value), i|
    category =
      parent_category.product_categories
        .where(name: value, path: "/#{parent_key}/#{key}")
        .first_or_create!

    next if parent_index > 1 || i > 1
    (16 * (1 - i) + rand(5)).times do |j|
      name = Faker::Product.product

      product = Product.create!(
        product_category: category,
        path_id: name.downcase.gsub(' ', '_'),
        name: name,
        factory_url: Faker::Internet.http_url,
        factory: Faker::Company.name,
        description: Faker::HipsterIpsum.paragraph,
        fabric: Faker::Color.name,
        wear_pct: rand(0..49) + rand,
        code: Faker::Product.model,
        warranty: (n = rand(0..2)) > 0 ? "#{n} year(s)" : "",
        price: rand(1..199) * 500
      )

      next if j > 3
      # product photos
      (rand(1..5)).times do
        photo = ProductPhoto.new(product: product)
        photo.src = File.open(Rails.root.join("app/assets/images/product_sample_1_big.jpg"))
        photo.save!
      end
    end
  end
end

p "ProductCategory: #{ProductCategory.count}, Product: #{Product.count}"

# product couples
id_range = (Product.minimum(:id)..Product.maximum(:id) - 4)
Product.all.each do |product|
  id = rand(id_range)

  product.product_couples = (0..rand(5) - 1)
    .lazy
    .map { |n| id + n }
    .map(&Product.method(:find))
    .reject { |couple| couple.id == product.id }
    .to_a
end


# ------------------------------------------------------------------------------
# Other
Slide.destroy_all if Rails.env.development?
5.times do
  Slide.create!(
    content: "<p>#{Faker::HipsterIpsum.sentence}</p>",
    src: File.open(Rails.root.join("app/assets/images/slider_sample.jpg"))
  )
end
