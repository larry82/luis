module Luis
  # Luis entity class
  class Entity < Base
    attr_accessor :entity, :type, :start_index, :end_index, :score, :value

    def resolution
      if @resolution.present?
        begin
          @resolution["values"]
        rescue
          nil
        end
      else
        nil
      end
    end

    def chinese_value
      values = resolution || [entity]
      values.map{ |v| v.gsub(' ','') }
    end

  end
end
