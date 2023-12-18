# Testing Java Script y Ajax

Añadimos la gema `gem "jasmine-rails"` al Gemfile para luego ejecutar el bundle, luego ejecutamos los siguientes comandos
```
rails generate jasmine_rails:install 
mkdir spec/javascripts/fixtures 
git add spec/javascripts 
```

Los cuales generarán dentro de la carpeta spec el directorio `javascripts/support/jasmine.yml` y el siguiente comando creará 
el directorio `javascripts/fixtures`. Para finalmente agregarlos al git.

Creamos el archivo `basic_check_spec.js` dentro del directorio `spec/javascripts` con el siguiente código:

```javascript
describe ('Jasmine basic check', function() { 
    it('works', function() { expect(true).toBe(true); }); 
}); 
```

Y para ejecutar pruebas de Jasmine corremos la aplicación y vamos a la ruta `/spec` de la aplicación.
