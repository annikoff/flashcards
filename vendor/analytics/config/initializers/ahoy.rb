# frozen_string_literal: true
require 'ahoy_matey'

class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  def track_visit(options, &block)
    @visit =
    visit_model.new do |v|
      v.visit_token = ahoy.visit_id
      v.visitor_token = ahoy.visitor_id
      v.user = user if v.respond_to?(:user=)
      v.started_at = options[:started_at]
    end

    set_visit_properties(visit)

    yield(visit) if block_given?

    begin
      visit.save!
      geocode(visit)
    rescue *unique_exception_classes
      # do nothing
    end
  end
  protected

  def visit_model
    Analytics::Visit
  end

  def event_model
    Analytics::Event
  end
end
