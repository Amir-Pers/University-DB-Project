from decimal import Decimal, InvalidOperation
from django import template

register = template.Library()

PERSIAN_DIGITS = str.maketrans(
    "0123456789",
    "۰۱۲۳۴۵۶۷۸۹",
)


@register.filter
def fa_number(value):

    if value in (None, ""):
        return ""

    try:
        number = Decimal(str(value))
    except (InvalidOperation, ValueError, TypeError):
        return value

    if number == number.to_integral():
        formatted = f"{int(number):,}"
    else:
        formatted = f"{number:,.2f}".rstrip("0").rstrip(".")

    return formatted.translate(PERSIAN_DIGITS)