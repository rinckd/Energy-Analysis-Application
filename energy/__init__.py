from pyramid.config import Configurator
from energy.resources import Root

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
     
    config = Configurator(root_factory=Root,
                          settings={'mako.directories':['energy:templates']})

    # routes for main form
    config.add_route('root', '', 
                    view='energy.views.form1',
                    renderer = 'energy:templates/form1.mako')

    config.add_route('form2', '/form2',
                     view='energy.views.form2',
                     view_renderer='energy:templates/form2.mako')

    # view results of data entry    
    config.add_route('results', '/results', 
                     view='energy.views.results',
                     renderer = 'energy:templates/results.mako')

    config.add_route('results2', '/results2', 
                  view='energy.views.results2',
                  renderer = 'energy:templates/results2.mako')

    # routes for adding a new Teacher to data form
    config.add_route('teacherAdd', '/teacheradd', 
                     view='energy.views.teacherAdd',
                     renderer = 'energy:templates/teacherAdd.mako')

    config.add_route('teacherAdd2', '/teacheradd2', 
                     view='energy.views.teacherAdd2',
                     renderer = 'energy:templates/teacherAdd2.mako')
 
    # route to download current data to excel
    config.add_route('test','/test', 
                     view='energy.views.test', 
                     renderer = 'energy:templates/data_dump.mako')      

    config.add_static_view('static', 'energy:static')
    return config.make_wsgi_app()
