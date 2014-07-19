#
#  Extremely simplistic state machine, not finite for certain :D
#
class ActiveRecord::Base
  def self.is_stateful *args, &block
    opts = args.extract_options!

    @by_field = opts[:by].to_s
    @initial = opts[:initial]

    self.class_eval %Q{ 
      def set_initial_state 
        self.#{@by_field} = "#{@initial}" if self.#{@by_field}.blank?
      end

      def current_state
        self.#{@by_field}.to_sym
      end
    }

    before_create :set_initial_state
    yield
  end

  def self.initial st
    @initial = st
  end

  def self.transition *args
    opts = args.extract_options!
    name, from, to = opts[:name], opts[:from], opts[:to]
    unless respond_to?("#{name.to_s}!")
      self.class_eval %Q{
        def #{name.to_s.downcase}!
          if self.#{@by_field}.to_sym == :#{from.to_s}
            self.#{@by_field} = "#{to.to_s}"
          else
            throw "Can't perform a transition, since initial state should be #{from.to_s}, but was " + self.#{@by_field}
          end
        end
      }
    end
  end
end
