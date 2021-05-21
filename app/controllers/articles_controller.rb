class ArticlesController < ApplicationController
  before_action :find_article, except: [:new, :create, :index, :from_author]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #se mandan a llamar a nivel de la clase, ejecuta un metodo antes de que se pase a ala acción de un controlador
  #podemos usar except: [: new, :create]

  def index
    @articles = Article.all
  end

  def show
  end

  def edit
    #despliega el formulario
    @categories = Category.all
  end

  def update
    #se manda a llevar desde el articulo que se quiere actualizar
    @article = Article.find(params[:id]) # traemos el objeto de la base de datos y actualizamos
    @article.update(article_params) # obtenemos los datos con los parametros que contienen el nombre del objeto, nombre del campo
    @article.save_categories
    redirect_to @article
  end

  def new
    #@article.title = 'Demo'
    @article = Article.new
    @categories = Category.all
  end

  def create
    #article viene de que al construir el formulario , lo estamos construyendo en base al objeto article
    @article = current_user.articles.create(article_params)
    @article.save_categories
    redirect_to @article
  end

  def destroy
    @article.destroy #eliminamos el objeto de la base de datos
    redirect_to root_path
  end

  def from_author
    @user = User.find(params[:user_id])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  #parametros fuertes, si no está en el parámetro entonces no lo guarda
  def article_params
    params.require(:article).permit(:title, :content, category_elements: [])
  end
end
