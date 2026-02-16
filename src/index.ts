import { JupyterFrontEndPlugin } from '@jupyterlab/application';
import { IThemeManager } from '@jupyterlab/apputils';

const plugin: JupyterFrontEndPlugin<void> = {
  id: 'jupyterlab-trillia-theme:plugin',
  autoStart: true,
  requires: [IThemeManager],
  activate: (app, manager: IThemeManager) => {
    const style = 'jupyterlab-trillia-theme/index.css';

    manager.register({
      name: 'Trillia',
      isLight: true,
      themeScrollbars: true,
      load: () => manager.loadCSS(style),
      unload: () => Promise.resolve(undefined)
    });
  }
};

export default plugin;
