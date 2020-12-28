using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PickablesProgress : MonoBehaviour
{
    Image[] _pickables;

    int _pickedIndex = 0;
    // Start is called before the first frame update
    void Start()
    {
        _pickables = GetComponentsInChildren<Image>();

        foreach (var p in _pickables)
        {
            p.color = Color.black;
        }

        var pickables = FindObjectsOfType<Pickable>();

        foreach (var item in pickables)
        {
            item.onPickedUp += PickedUp;
        }
    }
    
    void PickedUp()
    {
        _pickables[_pickedIndex].color = Color.white;

        _pickedIndex++;
    }
}
