class SurnameController < Controller
  def index
    @surnames = Surname.all
  end
  def new
    @title = "Новая запись"
  end

  def create(params)
    p params
    Surname.create(params)
    nil
  end

  def show(id)
    p id
    @surname = Surname.find(id: id.values.first)
    @title = @surname.title
    @comments = Comment.where(surname_id: id.values.first)
  end
end
