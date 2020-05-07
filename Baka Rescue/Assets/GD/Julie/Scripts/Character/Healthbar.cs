using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Healthbar : MonoBehaviour
{
    [SerializeField] private Slider _SliderHB = null;
    [SerializeField] private Gradient _gradient;
    [SerializeField] private Image _fill;

    public Slider SliderHB
    {
        get
        { return _SliderHB; }
        set
        { _SliderHB = value; }
    }

    public void SetMaxHealth(int health)
    {
        _SliderHB.maxValue = health;
        _SliderHB.value = health;

        _fill.color = _gradient.Evaluate(1f);
    }

    public void SetHealth(int health)
    {
        _SliderHB.value = health;
        _fill.color = _gradient.Evaluate(_SliderHB.normalizedValue);
    }
}
