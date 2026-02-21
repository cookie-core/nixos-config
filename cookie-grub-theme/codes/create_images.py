from PIL import Image, ImageColor
from pathlib import Path

base_dir = Path(__file__).resolve().parent
menu_background_path = base_dir / "../menu-background.png"
item_style_folder = base_dir / "../item-styled-box/"
selected_item_style_folder = base_dir / "../selected-item-styled-box/"

item_line_size = 5
base_size = 100
background_color = "#1C1C1C9C"
item_color = "#EDFFFFFF"
selected_item_color = "#7A9EDBFF"


def gradient_formula(x, all_size):
    return ((all_size - x) / all_size) ** 6

menu_background = Image.new("RGBA", ( base_size, base_size ), background_color)
menu_background.save(menu_background_path)

corners = [ "nw", "ne", "se", "sw" ]
corners_size = ( item_line_size, item_line_size )

for i in range(4):
    current_item_color = "#00000000"
    current_selected_item_color = "#00000000"

    if i == 0 or i == 3:
        current_item_color = item_color
        current_selected_item_color = selected_item_color

    item = Image.new("RGBA", corners_size, current_item_color)
    selected_item = Image.new("RGBA", corners_size, current_selected_item_color)

    item.save(f"{item_style_folder}/{corners[i]}.png")
    selected_item.save(f"{selected_item_style_folder}/{corners[i]}.png")


borders = [ "w", "n", "e", "s" ]
borders_sizes = [ ( item_line_size, base_size ), ( base_size, item_line_size ) ]

for i in range(4):
    current_item_color = "#00000000"
    current_selected_item_color = "#00000000"

    if i == 0:
        current_item_color = item_color
        current_selected_item_color = selected_item_color

    item = Image.new("RGBA", borders_sizes[i % 2], current_item_color)
    selected_item = Image.new("RGBA", borders_sizes[i % 2], current_selected_item_color)

    if i == 1 or i == 3:
        for x in range(base_size):
            for y in range(item_line_size):
                opacity = gradient_formula(x, base_size)
                opacity_int = int(opacity * 256)
                selected_item.putpixel((x, y), ImageColor.getrgb(selected_item_color)[:3] + (opacity_int,))

    item.save(f"{item_style_folder}/{borders[i]}.png")
    selected_item.save(f"{selected_item_style_folder}/{borders[i]}.png")


item_center = Image.new("RGBA", ( base_size, base_size ), "#00000000")
selected_item_center = Image.new("RGBA", ( base_size, base_size ), "#00000000")

for i in range(base_size):
    for j in range(base_size):
        opacity = gradient_formula(i, base_size)
        opacity_int = int(opacity * 256)
        selected_item_center.putpixel((i, j), ImageColor.getrgb(selected_item_color)[:3] + (opacity_int,))

item_center.save(f"{item_style_folder}/c.png")
selected_item_center.save(f"{selected_item_style_folder}/c.png")


