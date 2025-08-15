export type SpotItem = {
  id: string;
  domain: string;
  title: string;
  snippet?: string;
  keywords?: string[];
  url?: string;
  thumbnailBase64?: string;
  extra?: Record<string, any>;
};

export interface IndexItemsOptions {
  items: SpotItem[];
}

export interface DeleteItemsOptions {
  ids: string[];
}

export interface DeleteDomainOptions {
  domain: string;
}

export interface SpotSearchPlugin {
  indexItems(options: IndexItemsOptions): Promise<void>;
  deleteItems(options: DeleteItemsOptions): Promise<void>;
  deleteDomain(options: DeleteDomainOptions): Promise<void>;
}
