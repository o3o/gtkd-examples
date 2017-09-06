/**
 * Porting into D of [example 0]https://developer.gnome.org/gtk4/stable/gtk-getting-started.html#id-1.2.3.5)
 */
import std.stdio;
// named import and selective import,
// GioApplication is an alias for gio.Application.Application
import gio.Application : GioApplication = Application;

void activateExt(GioApplication gioa) {
   import gtk.ApplicationWindow : ApplicationWindow;
   import gtk.Application : Application;
   Application app = cast(Application)gioa;

   ApplicationWindow window = new ApplicationWindow(app);
   window.setTitle("Windows");
   window.setDefaultSize(200, 200);
   window.showAll();
}

int main(string[] args) {

   /**
    * GApplicationFlags is defined in gio.c.types
    * but gtkd/gtk/Application.d public import gio.c.types:
    * public import gio.c.types;
    */
   import gio.Application : GApplicationFlags;
   import gtk.Application : Application;

   auto application = new Application("eu.microline.gtk-examples.example1", GApplicationFlags.FLAGS_NONE);
   void activate(GioApplication a) {
      import gtk.ApplicationWindow : ApplicationWindow;
      ApplicationWindow window = new ApplicationWindow(application);
      window.setTitle("Windows");
      window.setDefaultSize(200, 200);
      window.showAll();
   }

   import std.functional: toDelegate;
   // in gio.Application.Application
   //gulong addOnActivate(void delegate(Application) dlg, ConnectFlags connectFlags=cast(ConnectFlags)0)
   application.addOnActivate(toDelegate(&activateExt));
   return application.run(args);
}
