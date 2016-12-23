# frozen_string_literal: true
require 'ahoy_matey'

class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  def track_visit(options, &block)
    params = {
      visit_token: ahoy.visit_id,
      visitor_token: ahoy.visitor_id,
      user: user,
      started_at: options[:started_at]
    }
    @visit = visit_model.new params

    set_visit_properties @visit

    yield(@visit) if block_given?

    @visit.save rescue nil
  end

  def track_event(name, properties, options, &block)
    params = {
      visit_id: visit&.id,
      name: name,
      properties: properties,
      user: user,
      time: options[:time]
    }
    event = event_model.new params

    yield(event) if block_given?

    event.save rescue nil
  end

  protected


  def visit
    @visit ||= visit_model.find_by visit_token: ahoy.visit_id
  end

  def visit_model
    Analytics::Visit
  end

  def event_model
    Analytics::Event
  end
end
