# == Schema Information
#
# Table name: event_agendas
#
#  id                :integer          not null, primary key
#  description       :text
#  end_time          :time
#  maximum_capacity  :integer
#  must_book         :boolean
#  name              :string           not null
#  price             :decimal(8, 2)    default(0.0)
#  start_time        :time
#  table_discount    :decimal(5, 2)    default(0.0)
#  table_size        :integer          default(10)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :integer
#  event_id          :integer
#
# Indexes
#
#  index_event_agendas_on_event_category_id  (event_category_id)
#  index_event_agendas_on_event_id           (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#  fk_rails_...  (event_id => events.id)
#
FactoryGirl.define do
  factory :event_agenda do
    sequence(:name) {|n| "Agenda #{ n }" }
    event_category
    event
    start_time { Time.now + 3.hours }
    end_time { Time.now + 5.hours }
    price 9.99

    description "Some text"
    maximum_capacity 5
    table_size 2
    table_discount 5.0
  end
end
