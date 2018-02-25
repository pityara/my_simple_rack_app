class SurnameController < Controller
  def index
    @surnames = Surname.all
  end
  def new
  end

  def create(params)
    Surname.create(params)
  end

  def show(id)
    p id
    @surname = Surname.find(id: id.values.first)
  end
end
