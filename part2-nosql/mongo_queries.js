// ============================================================
// Part 2.2 — MongoDB Operations
// Collection: product_catalog
// Run in mongosh or MongoDB Compass Shell
// ============================================================

// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.product_catalog.insertMany([
  {
    _id: "ELEC-101",
    product_name: "Samsung 32-inch 4K Smart Monitor",
    category: "Electronics",
    brand: "Samsung",
    price: 32999,
    currency: "INR",
    stock_available: 18,
    specifications: {
      resolution: "3840 x 2160",
      refresh_rate: "60Hz",
      panel_type: "VA",
      display_inches: 32,
      ports: ["HDMI 2.0", "DisplayPort 1.2", "USB-C"],
      voltage: "100-240V AC",
      warranty_years: 3
    },
    certifications: ["BIS", "ISI", "Energy Star"],
    tags: ["monitor", "4K", "work-from-home", "home-office"],
    rating: 4.4,
    reviews_count: 512,
    in_stock: true,
    created_at: new Date("2024-03-10T11:00:00Z")
  },
  {
    _id: "CLOTH-502",
    product_name: "Men's Slim Fit Cotton Formal Shirt",
    category: "Clothing",
    brand: "Peter England",
    price: 1199,
    currency: "INR",
    stock_available: 240,
    specifications: {
      fabric: "100% Cotton",
      fit_type: "Slim Fit",
      collar_type: "Spread Collar",
      sleeve: "Full Sleeve",
      available_sizes: ["S", "M", "L", "XL", "XXL"],
      available_colors: [
        { name: "White",      hex: "#FFFFFF" },
        { name: "Light Blue", hex: "#ADD8E6" },
        { name: "Mint Green", hex: "#98FF98" }
      ],
      wash_instructions: "Machine wash cold, iron on medium heat",
      occasion: ["Formal", "Office", "Semi-Casual"]
    },
    tags: ["shirt", "formal", "cotton", "office-wear"],
    rating: 4.2,
    reviews_count: 1340,
    in_stock: true,
    created_at: new Date("2024-01-22T08:30:00Z")
  },
  {
    _id: "GROC-901",
    product_name: "Aashirvaad Whole Wheat Atta 10kg",
    category: "Groceries",
    brand: "Aashirvaad",
    price: 389,
    currency: "INR",
    stock_available: 620,
    specifications: {
      weight_grams: 10000,
      expiry_date: new Date("2025-06-30"),
      manufactured_date: new Date("2024-06-01"),
      storage_instructions: "Store in a cool, dry place away from moisture",
      nutritional_info: {
        serving_size_grams: 30,
        calories_per_serving: 106,
        carbohydrates_g: 22,
        protein_g: 3.5,
        fat_g: 0.5,
        fibre_g: 2.8
      },
      fssai_license: "10016011002253",
      is_organic: false,
      is_vegan: true,
      country_of_origin: "India"
    },
    tags: ["atta", "wheat", "staples", "daily-essentials"],
    rating: 4.6,
    reviews_count: 3821,
    in_stock: true,
    created_at: new Date("2024-06-01T06:00:00Z")
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.product_catalog.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  },
  {
    product_name: 1,
    brand: 1,
    price: 1,
    "specifications.warranty_years": 1
  }
);

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
// Note: expiry_date is stored as a BSON Date inside specifications,
// so the filter uses a Date object for correct comparison.
db.product_catalog.find(
  {
    category: "Groceries",
    "specifications.expiry_date": { $lt: new Date("2025-01-01") }
  },
  {
    product_name: 1,
    brand: 1,
    price: 1,
    "specifications.expiry_date": 1
  }
);

// OP4: updateOne() — add a "discount_percent" field to a specific product
// Applying a 10% seasonal discount to the Samsung Monitor (ELEC-101)
db.product_catalog.updateOne(
  { _id: "ELEC-101" },
  {
    $set: {
      discount_percent: 10,
      discounted_price: 29699
    }
  }
);

// OP5: createIndex() — create an index on the category field
// Every find(), filter, and aggregation in this catalog is scoped by
// category first. Without an index, MongoDB performs a full collection
// scan (O(n)) on every such query. A B-tree index on category reduces
// that to O(log n), which becomes critical as the catalog scales to
// hundreds of thousands of SKUs across dozens of categories.
db.product_catalog.createIndex(
  { category: 1 },
  { name: "idx_category", background: true }
);

// Verify the index was created successfully
db.product_catalog.getIndexes();
