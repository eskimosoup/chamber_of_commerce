module Optimadmin
  class EventAgendaPresenter < Optimadmin::BasePresenter
    presents :event_agenda

    def name
      event_agenda.name
    end

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def start_time
      h.l event_agenda.start_time, format: :short
    end

    def end_time
      h.l event_agenda.end_time, format: :short
    end

    def category
      event_agenda.event_category.name
    end

    def content
      h.raw event_agenda.content
    end

    def price
      h.number_to_currency event_agenda.price
    end

    def table_size
      event_agenda.table_size
    end

    def table_discount
      h.number_to_percentage(event_agenda.table_discount, precision: 2)
    end

    def edit_link
      h.link_to pencil, h.edit_event_event_agenda_path(event_agenda.event_id, event_agenda), class: 'menu-item-control'
    end

    def delete_link
      h.link_to trash_can, h.event_event_agenda_path(event_agenda.event_id, event_agenda), method: :delete,
        data: { confirm: 'Are you sure?' }, class: 'menu-item-control'
    end
  end
end
