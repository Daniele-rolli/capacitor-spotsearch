import { WebPlugin } from '@capacitor/core';

import type {
  SpotSearchPlugin,
  IndexItemsOptions,
  DeleteItemsOptions,
  DeleteDomainOptions,
} from './definitions';

export class SpotSearchWeb extends WebPlugin implements SpotSearchPlugin {
  private mem = new Map<string, any>();
  private indexingEnabled = false; // <- opt-in flag

  // Method for developer or user settings to enable indexing
  async enableIndexing(enabled: boolean): Promise<void> {
    this.indexingEnabled = enabled;
  }

  async indexItems({ items }: IndexItemsOptions): Promise<void> {
    if (!this.indexingEnabled) return; // <- opt-in check
    items.forEach(i => this.mem.set(i.id, i));
  }

  async deleteItems({ ids }: DeleteItemsOptions): Promise<void> {
    if (!this.indexingEnabled) return; // optional: only allow if indexing is on
    ids.forEach(id => this.mem.delete(id));
  }

  async deleteDomain({ domain }: DeleteDomainOptions): Promise<void> {
    if (!this.indexingEnabled) return; // optional
    [...this.mem.values()].forEach((v: any) => {
      if (v.domain === domain) this.mem.delete(v.id);
    });
  }
}
