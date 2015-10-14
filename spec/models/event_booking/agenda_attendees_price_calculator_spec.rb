require "rails_helper"

RSpec.describe EventBooking::AgendaAttendeesPriceCalculator, type: :model do

  describe "working out tables needed" do
    let(:event_agenda) { build(:event_agenda, table_size: 2) }

    describe "event agenda has no tables" do
      let(:event_agenda) { build(:event_agenda, table_size: 0) }
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 2) }

      it "should have no tables" do
        expect(agenda_price_calc.tables).to eq(0)
      end

      it "should have 2 individuals" do
        expect(agenda_price_calc.individuals).to eq(2)
      end

      it "should return the price correctly, with no discount" do
        expect(agenda_price_calc.price).to eq((agenda_price_calc.number_of_attendees * event_agenda.price))
      end
    end

    describe "no attendees" do
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 0) }

      it "should have no tables" do
        expect(agenda_price_calc.tables).to eq(0)
      end

      it "should have no individuals" do
        expect(agenda_price_calc.individuals).to eq(0)
      end
    end

    describe "one attendee" do
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 1) }

      it "should have no tables" do
        expect(agenda_price_calc.tables).to eq(0)
      end

      it "should have one individual" do
        expect(agenda_price_calc.individuals).to eq(1)
      end
    end

    describe "two attendees - a full table" do
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 2) }

      it "should have one table" do
        expect(agenda_price_calc.tables).to eq(1)
      end

      it "should have no individuals" do
        expect(agenda_price_calc.individuals).to eq(0)
      end
    end

    describe "five attendees - a full table and an individual" do
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 5) }

      it "should have two tables" do
        expect(agenda_price_calc.tables).to eq(2)
      end

      it "should have one individual" do
        expect(agenda_price_calc.individuals).to eq(1)
      end
    end
  end

  describe "working out the table price" do
    describe "no discount" do
      let(:event_agenda) { build(:event_agenda, table_size: 2, table_discount: 0, price: 10.0) }
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 2) }

      it "should return the normal price" do
        expect(agenda_price_calc.price_per_table).to eq(20)
      end
    end

    describe "with discount" do
      let(:event_agenda) { build(:event_agenda, table_size: 2, table_discount: 5, price: 10.0) }
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 2) }

      it "should return the discounted price" do
        expect(agenda_price_calc.price_per_table).to eq(19)
      end
    end
  end

  describe "working out individuals" do
    let(:event_agenda) { build(:event_agenda, table_size: 10, table_discount: 5, price: 10.0) }
    subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 5) }

    it "should return the price for tables" do
      expect(agenda_price_calc.individuals_price).to eq(50)
    end
  end

  describe "working out the full price" do
    describe "agenda with no attendees" do
      let(:event_agenda) { build(:event_agenda) }
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 0) }

      it "should return 0" do
        expect(agenda_price_calc.price).to eq(0)
      end
    end
    describe "no discount on tables" do
      let(:event_agenda) { build(:event_agenda, table_discount: 0, price: 10.0) }
      subject(:agenda_price_calc) { EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 5) }

      it "should times the price by the attendees" do
        expect(agenda_price_calc.price).to eq(50)
      end
    end

    describe "discount on tables" do
      let(:event_agenda) { build(:event_agenda, table_size: 2, table_discount: 5, price: 10.0) }

      it "works out the price when there are full tables" do
        agenda_price_calc = EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 4)
        expect(agenda_price_calc.price).to eq(38)
      end

      it "works out the price correctly when tables are not full" do
        agenda_price_calc = EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: event_agenda, number_of_attendees: 5)
        expect(agenda_price_calc.price).to eq(48)
      end
    end
  end


end