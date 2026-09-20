export interface HistoryPhoto {
  src: string;
  caption: string;
  year?: number;
}

export const photos: HistoryPhoto[] = [
  { src: '/images/history/Heren_1_2002_2003.jpg', caption: 'Heren 1', year: 2002 },
  { src: '/images/history/Heren_1_bekerwinst.jpg', caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { src: '/images/history/Heren_1_bekerwinst_2.jpg', caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { src: '/images/history/Heren_OuwZakkenMatch_2019.JPG', caption: 'Ouw Zakken Match', year: 2019 },
  { src: '/images/history/Heren_OuwZakkenMatch_2019_2.JPG', caption: 'Ouw Zakken Match', year: 2019 }
];

export const fuifPhotos: HistoryPhoto[] = Array.from({ length: 43 }, (_, index) => ({
  src: `/images/history/Fuif/photo${String(index + 1).padStart(2, '0')}.jpg`,
  caption: 'Spora fuif - Zaal Pacem'
}));

export const allHistoryPhotos = [...photos, ...fuifPhotos];
const historyPhotoHrefBySrc = new Map(
  allHistoryPhotos.map((photo, index) => [photo.src, `/history/images/${index + 1}`])
);

export function getHistoryPhotoHref(photo: HistoryPhoto) {
  const href = historyPhotoHrefBySrc.get(photo.src);

  if (!href) {
    throw new Error(`Unknown history photo: ${photo.src}`);
  }

  return href;
}
