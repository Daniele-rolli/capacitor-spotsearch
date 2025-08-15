import { registerPlugin } from '@capacitor/core';

import type { SpotSearchPlugin } from './definitions';

export * from './definitions';

export const SpotSearch = registerPlugin<SpotSearchPlugin>('SpotSearch', {
  web: () => import('./web').then(m => new m.SpotSearchWeb()),
});
