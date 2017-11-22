module Response
  def json_response(object, status = :ok, excluded = [])
    j_objects = JSON.parse(object.to_json)

    if j_objects.kind_of?(Array)
      j_objects.each do |obj|
        excluded.each { |param| obj.delete(param) }
      end
    else
      excluded.each { |param| j_objects.delete(param) }
    end

    render json: j_objects, status: status
  end
end
