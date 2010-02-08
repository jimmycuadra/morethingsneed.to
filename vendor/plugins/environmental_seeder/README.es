EnvironmentalSeeder
===================

EnvironmentalSeeder es un simple agregado a db:seed para permitir cargar datos especificos dependiendo del entorno sin necesidad de usar condicionales en seeds.rb
Hay que tener en cuenta que no se reemplaza db:seed, sólo agrega la funcionalidad de cargar los seeds dependiendo del environment.
Instalación
===========
Instalalo como cualquier plugin de rails

  $ script/plugin install git://github.com/franciscotufro/environmental_seeder.git

Ejemplo
=======
Para cargar datos en todos los entornos alcanza con seguir usando seeds.rb, y usar seeds/[RAILS_ENV].rb para los específicos de un entorno.
Por ejemplo, un usuario administrador que debería ser creado en todos los entornos debería ponerse en seeds.rb
  db/seeds.rb
  --------
  User.create(:login => 'admin', :password => 'secret', :password_confirmation => 'secret')
Luego, si uno quisiera agregar un post escrito por admin en staging alcanzaría con hacer lo siguiente

  db/seeds/staging.rb
  ----------------
  admin = User.find_by_login('admin')
  Post.create(:title => "Some data to populate staging environment", :author => admin)

Ahora, si corremos
  $ RAILS_ENV=staging rake db:seed
  Loading seeds_staging.rb

alcanza, ahora la base de datos de staging va a tener tanto el usuario admin como el post, facil no?