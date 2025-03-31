document.addEventListener("DOMContentLoaded", () => {
  // Dropdown functionality
  const dropdownToggles = document.querySelectorAll(".dropdown-toggle");

  dropdownToggles.forEach((toggle) => {
    toggle.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();

      const dropdownMenu = this.nextElementSibling;

      // Toggle dropdown
      if (dropdownMenu.classList.contains("show")) {
        dropdownMenu.classList.remove("show");
      } else {
        // Close all other dropdowns
        document.querySelectorAll(".dropdown-menu").forEach((menu) => {
          menu.classList.remove("show");
        });

        // Open this dropdown
        dropdownMenu.classList.add("show");
      }
    });
  });

  // Close dropdowns when clicking outside
  document.addEventListener("click", (event) => {
    if (!event.target.closest(".dropdown-container")) {
      document.querySelectorAll(".dropdown-menu").forEach((menu) => {
        menu.classList.remove("show");
      });
    }
  });

  // Equal height for news cards
  function equalizeCardHeights() {
    const newsCards = document.querySelectorAll(".new");

    // Reset heights
    newsCards.forEach((card) => {
      card.style.height = "auto";
    });

    // Group cards by rows
    const rows = {};
    newsCards.forEach((card) => {
      const rect = card.getBoundingClientRect();
      const row = Math.floor(rect.top);

      if (!rows[row]) {
        rows[row] = [];
      }

      rows[row].push(card);
    });

    // Set equal height for each row
    Object.values(rows).forEach((rowCards) => {
      let maxHeight = 0;

      rowCards.forEach((card) => {
        maxHeight = Math.max(maxHeight, card.offsetHeight);
      });

      rowCards.forEach((card) => {
        card.style.height = maxHeight + "px";
      });
    });
  }

  // Run on load and resize
  window.addEventListener("load", equalizeCardHeights);
  window.addEventListener("resize", () => {
    // Debounce resize event
    clearTimeout(window.resizeTimer);
    window.resizeTimer = setTimeout(equalizeCardHeights, 200);
  });

  // Sidebar item heights
  function equalizeSidebarItemHeights() {
    const sidebarItems = document.querySelectorAll(".boxnlx, .boxtmn, .boxtdx");

    sidebarItems.forEach((item) => {
      const image = item.querySelector(".imgnlx img, .imgtmn img, .imgtdx img");
      if (image) {
        image.style.height = "60px";
        image.style.objectFit = "cover";
      }
    });
  }

  // Run on load
  window.addEventListener("load", equalizeSidebarItemHeights);
});