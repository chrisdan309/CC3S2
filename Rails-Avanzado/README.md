# Rails-Avanzado

## Parte 1

Comenzamos copiando el código dentro del movie.rb

```ruby
class Movie < ActiveRecord::Base
    def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end #  shortcut: array of strings
    validates :title, :presence => true
    validates :release_date, :presence => true
    validate :released_1930_or_later # uses custom validator below
    validates :rating, :inclusion => {:in => Movie.all_ratings},
        :unless => :grandfathered?
    def released_1930_or_later
        errors.add(:release_date, 'must be 1930 or later') if
        release_date && release_date < Date.parse('1 Jan 1930')
    end
    @@grandfathered_date = Date.parse('1 Nov 1968')
    def grandfathered?
        release_date && release_date < @@grandfathered_date
    end
end
```

Procedemos a comprobar los resultados usando rails console

![](https://github.com/chrisdan309/Rails-Avanzado/blob/main/Images/imagen_1.png?raw=true)

Este resultado nos expresa que esta instancia no es válida dado que no cumple con ciertas características expresadas en el código, en este caso al crear una instancia mediante el método new no cumple con la condición "can't be blank" y que sea mayor que 1930, por ende no es válido.

Explica el siguiente código:

```ruby
class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end 
  def create
    if (@movie = Movie.create(movie_params))
      redirect_to movies_path, :notice => "#{@movie.title} created."
    else
      flash[:alert] = "Movie #{@movie.title} could not be created: " +
        @movie.errors.full_messages.join(",")
      render 'new'
    end
  end
  def edit
    @movie = Movie.find params[:id]
  end
  def update
    @movie = Movie.find params[:id]
    if (@movie.update_attributes(movie_params))
      redirect_to movie_path(@movie), :notice => "#{@movie.title} updated."
    else
      flash[:alert] = "#{@movie.title} could not be updated: " +
        @movie.errors.full_messages.join(",")
      render 'edit'
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, :notice => "#{@movie.title} deleted."
  end
  private
  def movie_params
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)
  end
end
```

*new:* Crea una nueva instancia de la clase movie.

*create:* Crea una nueva movie con los datos que recibe del formulario, si lo crea correctamente lo redirige al moviespath, mostrando el mensaje movie.title created. Si no se crea correctamente nos mostrará un mensaje que dice que no se pudo crear y luego redirige a new.

*edit:* Nos permite encontrar una movie respecto a su id.

*update:* Actualiza los datos de una movie respecto a su id, verifica el objeto al actualizar los atributos y realiza un comportamiento similar al de new.

*destroy:* Elimina una movie al buscar su id y luego redirige a movie_path.

*movie_params:* Esta función verifica que el parámetro movie exista, Luego selecciona los atributo que son permitidos para la el create y edit de este objeto.

Comprobamos los resultados en consola

![](https://github.com/chrisdan309/Rails-Avanzado/blob/main/Images/imagen_2.png?raw=true)

AL utilizar el método create! este válida los datos ingresados antes de insertarlos a la base de datos.

## SSO y autenticación a través de terceros

Comenzamos representando al usuario como un moviegoer utilizando el siguiente comando

```
rails generate model Moviegoer name:string provider:string uid:string
```

Luego editamos el modelo del moviegoer.rb

```ruby
# Edit app/models/moviegoer.rb to look like this:
class Moviegoer < ActiveRecord::Base
    def self.create_with_omniauth(auth)
        Moviegoer.create!(
        :provider => auth["provider"],
        :uid => auth["uid"],
        :name => auth["info"]["name"])
    end
end
```

Dado que usaremos la gema de Omniauth, la agregaremos al gemfile para realizar las autenticaciones.

```
gem "omniauth-twitter"
```

Utilizamos omniauth-twitter porque utilizaremos la API de twitter. Luego generamos el sessionscontroller.

```ruby
class SessionsController < ApplicationController
  # login & logout actions should not require user to be logged in
  skip_before_filter :set_current_user  # check you version
  def create
    auth = request.env["omniauth.auth"]
    user =
      Moviegoer.where(provider: auth["provider"], uid: auth["uid"]) ||
        Moviegoer.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to movies_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end
```

y dentro de config/initializers/omniauth.rb colocamos las keys que nos proporcionó twitter.

![](https://github.com/chrisdan309/Rails-Avanzado/blob/main/Images/imagen_3.png?raw=true)

Donde ingresamos los valores de "API_KEY" y "API_SECRET".

## Asociaciones y claves foráneas

El markdown nos pide explicar la siguiente línea de SQL:

```sql
SELECT reviews.*
    FROM movies JOIN reviews ON movies.id=reviews.movie_id
    WHERE movies.id = 41;
```

La cual nos muestra las filas utilizando todos los atributos de la tabla movies, la cual la asocia con la tabla reviews siempre y cuando tengan el mismo id, para luego filtrar cuando el movies.id=41

Ahora realizamos los sisguientes cambios en la aplicación:

Creamos la migración para crear la tabla reviews con claves foráneas:

```ruby
class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table 'reviews' do |t|
      t.integer    'potatoes'
      t.text       'comments'
      t.references :moviegoer
      t.references :movie
    end
  end
end
```

Y ahora creamos un modelo del review.rb

```ruby
class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :moviegoer
end
```

Y luego insertamos dentro de movie.rb y moviegoer.rb la siguiente línea
```ruby
has_many :reviews
```

Ahora realizamos un ejemplo usando la consola de rails

![](https://github.com/chrisdan309/Rails-Avanzado/blob/main/Images/imagen_4.png?raw=true)


