from datetime import datetime, timedelta

""" This function returns next full hour in given format (optional). Default format is %H.%M """


def get_next_full_hour(time_format = '%H.%M'):
    now = datetime.now()
    next_hour_date = now.replace(microsecond=0, second=0, minute=0) + timedelta(hours=1)
    return next_hour_date.strftime(time_format)


""" This function returns current date in given format. """


def get_current_date(date_format: str) -> str:
    now = datetime.now()
    return now.strftime(date_format)


""" This function returns future date in given format and with given amount of days ahead. """


def get_future_date(days_ahead: int, date_format: str) -> str:
    now = datetime.now()
    future_date = now + timedelta(days=days_ahead)
    return future_date.strftime(date_format)


""" This function returns sorted or unsorted items of given list and given selection. """


def get_sorted_or_not_sorted_items_from_list(orig_list, list_type):
    sorted = []
    list_max_value = max(orig_list)
    for curr, next in zip(orig_list, orig_list[1:]):
        if curr < next:
            sorted.append(curr)
            if next == list_max_value:
                sorted.append(next)
                break
    unsorted = remove_list_of_items_from_list(sorted, orig_list)
    if list_type == 'sorted':
        return sorted
    elif list_type == 'unsorted':
        return unsorted


""" This function returns given list_a without items given in list_b. """


def remove_list_of_items_from_list(list_a, list_b):
    return list_b[len(list_a):]


""" This function returns float number found on given string. """


def get_float_from_string(st: str) -> float:
    for i in st.split():
        try:
            result = float(i)
            break
        except:
            continue
    return result


""" This function returns item from given list which contains given string. """


def get_item_from_list_if_item_contains_str(li: list, st: str) -> str:
    search_str = str(st)
    for item in li:
        if search_str in item:
            return item


""" This function returns even number as integer if given float is even. E.g. fl=3.0 -> 3. """


def return_even_number_as_integer_if_float_is_even(fl):
    if fl % 1 == 0.0:
        return int(fl)
    else:
        return fl


""" This function returns True or False if given key exists in given dictionary. """


def get_status_is_key_found_in_dictionary(dictionary, key):
    return key in dictionary
