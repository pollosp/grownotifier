class GetVariation
  def initialize (initial_value,final_value)
    @initial_value = initial_value
    @final_value = final_value
  end
  def percentual
   (((@final_value-@initial_value).to_f/@initial_value)*100).round(2)
  end
end
