using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenGO : IScreen
{
    //Diccionario para que segun un behaviour, saber como esta su estado (activo o no)
    Dictionary<Behaviour, bool> _before = new Dictionary<Behaviour, bool>();

    public Transform root;

    public ScreenGO(Transform root)
    {
        this.root = root;
    }
    
    public void Activate()
    {
        foreach (var keyValue in _before)
        {
            keyValue.Key.enabled = keyValue.Value;
        }
        _before.Clear();
    }

    public void Deactivate()
    {
        foreach (var b in root.GetComponentsInChildren<Behaviour>())
        {
            _before[b] = b.enabled;
            b.enabled = false;
        }
    }

    public void Free()
    {
        GameObject.Destroy(root.gameObject);
    }
}
