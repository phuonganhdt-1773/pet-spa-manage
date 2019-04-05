FactoryBot.define do
  factory :post do
    title { "Phuc" }
    content { FFaker::Lorem.paragraphs}
    sumary { "lien" }
  end
end
