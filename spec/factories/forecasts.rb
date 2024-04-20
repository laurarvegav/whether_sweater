FactoryBot.define do
  factory :forecast do
    current_weather do
      { 
        last_updated: Faker::Date.between(from: '2024-04-13', to: '2024-04-20'),
        temperature: Faker::Number.between(from: 0.0, to: 56.7),
        feels_like: Faker::Number.between(from: 0.0, to: 56.7),
        humidity: Faker::Number.between(from: 0.0, to: 100),
        uvi: Faker::Number.between(from: 1.0, to: 11),
        visibility: Faker::Number.between(from: 0.0, to: 10),
        condition: Faker::Adjective.positive,
        icon: Faker::File.mime_type(media_type: 'image')
      }
    end
    
    daily_weather do
      { 
        date: Faker::Date.between(from: '2024-04-13', to: '2024-04-20'),
        sunrise: "#{Faker::Number.between(from: 1, to: 12)}:#{Faker::Number.between(from: 10, to: 59)} AM",
        sunset: "#{Faker::Number.between(from: 1, to: 12)}:#{Faker::Number.between(from: 10, to: 59)} PM",
        max_temp: Faker::Number.between(from: 0.0, to: 56.7),
        min_temp: Faker::Number.between(from: 0.0, to: 56.7),
        condition: Faker::Adjective.positive,
        icon: Faker::File.mime_type(media_type: 'image')
       }
    end

    hourly_weather do
      { 
        time: "#{Faker::Number.between(from: 1, to: 12)}:#{Faker::Number.between(from: 10, to: 59)} AM",
        temperature: Faker::Number.between(from: 0.0, to: 56.7),
        conditions: Faker::Adjective.positive,
        icon: Faker::File.mime_type(media_type: 'image')
      }
    end
  end
end
