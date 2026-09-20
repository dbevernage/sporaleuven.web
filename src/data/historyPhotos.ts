export interface HistoryPhoto {
  id: string;
  src: string;
  caption: string;
  year?: number;
}

export const photos: HistoryPhoto[] = [
  { id: 'heren-1-2002-2003', src: '/images/history/Heren_1_2002_2003.jpg', caption: 'Heren 1', year: 2002 },
  { id: 'heren-1-bekerwinst', src: '/images/history/Heren_1_bekerwinst.jpg', caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { id: 'heren-1-bekerwinst-2', src: '/images/history/Heren_1_bekerwinst_2.jpg', caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { id: 'heren-ouw-zakken-match-2019', src: '/images/history/Heren_OuwZakkenMatch_2019.JPG', caption: 'Ouw Zakken Match', year: 2019 },
  { id: 'heren-ouw-zakken-match-2019-2', src: '/images/history/Heren_OuwZakkenMatch_2019_2.JPG', caption: 'Ouw Zakken Match', year: 2019 }
];

export const fuifPhotos: HistoryPhoto[] = Array.from({ length: 43 }, (_, index) => ({
  id: `fuif-photo-${String(index + 1).padStart(2, '0')}`,
  src: `/images/history/Fuif/photo${String(index + 1).padStart(2, '0')}.jpg`,
  caption: 'Spora fuif - Zaal Pacem'
}));

export const allHistoryPhotos = [...photos, ...fuifPhotos];
const historyPhotoHrefById = new Map(
  allHistoryPhotos.map((photo, index) => [photo.id, `/history/images/${index + 1}`])
);

export function getHistoryPhotoHref(photo: HistoryPhoto) {
  const href = historyPhotoHrefById.get(photo.id);

  if (!href) {
    throw new Error(`Unknown history photo: ${photo.src}`);
  }

  return href;
}
