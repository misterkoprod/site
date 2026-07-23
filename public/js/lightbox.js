const lightbox = document.querySelector("#lightbox");
const lightboxImage = document.querySelector(".lightbox-image");
const closeButton = document.querySelector(".lightbox-close");
const prevButton = document.querySelector(".lightbox-prev");
const nextButton = document.querySelector(".lightbox-next");

const galleryButtons = Array.from(document.querySelectorAll(".gallery-item[data-full]"));
const thumbButtons = Array.from(document.querySelectorAll(".lightbox-thumb[data-full]"));

let currentIndex = 0;

function showImage(index) {
  if (!lightbox || !lightboxImage || galleryButtons.length === 0) return;

  currentIndex = (index + galleryButtons.length) % galleryButtons.length;

  const imageUrl = galleryButtons[currentIndex].dataset.full;
  lightboxImage.src = imageUrl;
  lightbox.hidden = false;

  thumbButtons.forEach((thumb, thumbIndex) => {
    thumb.classList.toggle("is-active", thumbIndex === currentIndex);
  });
}

function closeLightbox() {
  if (!lightbox || !lightboxImage) return;

  lightbox.hidden = true;
  lightboxImage.src = "";
}

galleryButtons.forEach((button, index) => {
  button.addEventListener("click", () => {
    showImage(index);
  });
});

thumbButtons.forEach((button, index) => {
  button.addEventListener("click", () => {
    showImage(index);
  });
});

prevButton?.addEventListener("click", () => {
  showImage(currentIndex - 1);
});

nextButton?.addEventListener("click", () => {
  showImage(currentIndex + 1);
});

closeButton?.addEventListener("click", closeLightbox);

lightbox?.addEventListener("click", (event) => {
  if (event.target === lightbox) {
    closeLightbox();
  }
});

document.addEventListener("keydown", (event) => {
  if (!lightbox || lightbox.hidden) return;

  if (event.key === "Escape") closeLightbox();
  if (event.key === "ArrowLeft") showImage(currentIndex - 1);
  if (event.key === "ArrowRight") showImage(currentIndex + 1);
});