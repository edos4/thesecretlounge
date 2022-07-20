class OptionalHash < Struct.new(:value)
  def and_then(&block)
    if value.nil?
      OptionalHash.new(nil)                                              
    else
      block.call(value)
    end
  end
                                                                                                                    
  def method_missing(*args, &block)
    and_then do |value|
      if(value.class == Hash && value.has_key?(*args))
        OptionalHash.new(value.fetch(*args, &block))
      else
        OptionalHash.new(nil)
      end
    end
  end
end 